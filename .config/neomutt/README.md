# Neomutt Configuration

Email client configuration for 2 Gmail accounts with OAuth2 authentication and image support in Ghostty.

## Features

- **2 Gmail Accounts**: Easy switching between accounts with F2/F3 keys
- **OAuth2 Authentication**: Modern, secure authentication using Google's OAuth2 (no app passwords needed)
- **Contact Autocomplete**: Tab completion with Google Contacts (via macOS Contacts sync)
- **Image Support**: View images using chafa with Kitty graphics protocol (compatible with Ghostty)
- **HTML Email**: Rendered with elinks (felinks) with improved paragraph spacing for readability
- **Open in Gmail**: Quick access to view emails in Gmail web interface with images
- **Bex Codes Theme**: Custom rainbow/purple color palette matching your other themes
- **Gmail-Optimized**: Proper folder structure and settings for Gmail IMAP
- **Vim-style Navigation**: Familiar keybindings (gg, G, j, k, /, n, N)

## Prerequisites

### 1. Install Required Packages

All packages are managed via Brewfile:

```bash
cd ~/dotfiles
brew bundle install
```

This installs:
- `neomutt` - Email client
- `w3m` - Text-based web browser
- `felinks` - Enhanced text browser (elinks fork) with CSS support for HTML emails
- `urlscan` - URL extractor
- `chafa` - Image viewer with Kitty graphics protocol
- `lbdb` - Little Brother's Database for contact lookup

### 2. Enable IMAP in Gmail

For each Gmail account:

1. Go to Gmail Settings → **Forwarding and POP/IMAP**
2. Enable **IMAP access**
3. Save changes

### 3. Set Up GPG Encryption

OAuth2 tokens should be encrypted. Create a GPG key:

```bash
gpg --full-generate-key
```

When prompted:
- **Key type**: Press Enter (RSA and RSA)
- **Key size**: `4096`
- **Expiration**: `0` (no expiration) or `2y` (2 years)
- **Real name**: Your name
- **Email**: Your primary email address
- **Comment**: Press Enter to skip
- **Passphrase**: Enter a strong passphrase (save in 1Password!)

**Configure GPG agent to cache passphrase for 8 hours:**

```bash
echo "default-cache-ttl 28800" >> ~/.gnupg/gpg-agent.conf
echo "max-cache-ttl 28800" >> ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
```

Now you'll only need to enter your passphrase once per session.

### 4. Set Up Google OAuth2 Credentials

Google no longer supports app-specific passwords. You need to create OAuth2 credentials:

1. Visit: https://console.cloud.google.com/
2. Create a new project (or use existing)
3. Enable the **Gmail API** for your project
4. Go to **Credentials** → **Create Credentials** → **OAuth client ID**
5. Choose **Desktop app** as application type
6. **Download the credentials JSON file**
7. Save it to: `~/.config/neomutt/credentials/client_secret.json`

The credentials file will be used for all your accounts.

### 5. Generate OAuth2 Tokens for Your Accounts

For each account configuration file you have, generate an OAuth2 token using your `client_secret.json` file:

```bash
# Replace TOKEN_NAME with your account name (e.g., bex-codes, gd)
# Replace YOUR_EMAIL with your actual Gmail address
python3 ~/.config/neomutt/scripts/mutt_oauth2.py \
  ~/.config/neomutt/tokens/TOKEN_NAME.token \
  --verbose \
  --authorize \
  --provider google \
  --client-secret-file ~/.config/neomutt/credentials/client_secret.json \
  --email YOUR_EMAIL@gmail.com
```

This will:
- Read client_id and client_secret from your credentials file
- Open a browser for Google authorization
- Ask you to sign in and grant permissions
- Save the encrypted refresh token to `~/.config/neomutt/tokens/TOKEN_NAME.token`

Repeat this process for each Gmail account you want to configure.

**Note:** Tokens are encrypted with GPG by default. Make sure you have GPG set up and a key configured.

See `~/.config/neomutt/tokens/README.md` for more details about token files.

### 6. Test OAuth2 Tokens

Verify each token works:

```bash
# Test your token
python3 ~/.config/neomutt/scripts/mutt_oauth2.py \
  ~/.config/neomutt/tokens/TOKEN_NAME.token
```

Each should output a valid access token. If not, re-run the authorization step.

### 7. Set Up Contacts Integration

Neomutt uses LBDB (Little Brother's Database) for contact lookup and autocomplete.

**Enable Google Contacts sync in macOS:**

1. Open **System Settings** → **Internet Accounts**
2. Ensure your Gmail accounts (bex.codes and gdnz.org) are added
3. Enable **Contacts** checkbox for each account
4. macOS will automatically sync Google Contacts to Contacts.app

**How it works:**

- Press **Tab** while typing email addresses to autocomplete
- LBDB searches:
  - macOS Contacts (synced from Google)
  - Email addresses learned from sent/received mail
  - Manual aliases in `~/.config/neomutt/aliases`
- Results update automatically as Google Contacts sync

**Optional - Add manual aliases:**

Edit `~/.config/neomutt/aliases` to add frequently used contacts:

```bash
alias john John Doe <john@example.com>
alias jane Jane Smith <jane@example.com>
```

**Test contact lookup:**

```bash
# Test LBDB query
lbdbq 'name'

# Or test in neomutt by composing an email and pressing Tab
```

## Configuration

### Account Configuration Files

Account configuration files should be named with the pattern `*-account.rc` (e.g., `work-account.rc`, `personal-account.rc`).

**To create a new account:**

1. Copy the example template:
   ```bash
   cd ~/.config/neomutt/accounts
   cp example-account.rc myaccount-account.rc
   ```

2. Edit the new file:
   ```bash
   nvim myaccount-account.rc
   ```

3. Replace the placeholder values:
   - `your-email@gmail.com` → Your actual Gmail address
   - `Your Name` → Your actual name
   - `your-account-name` → Match your filename (e.g., `myaccount`)

4. Create cache directories:
   ```bash
   mkdir -p ~/.cache/neomutt/myaccount/{headers,messages}
   ```

The main configuration will automatically source the first `*-account.rc` file it finds (alphabetically, excluding `example-account.rc`) as your default account.

**To set up account switching:**

Edit `~/.config/neomutt/neomuttrc` and uncomment/customize the folder-hooks and macros section:

```neomuttrc
# Folder hooks for automatic switching
folder-hook 'work@company.com' 'source ~/.config/neomutt/accounts/work-account.rc'
folder-hook 'personal@gmail.com' 'source ~/.config/neomutt/accounts/personal-account.rc'

# Macros for manual switching (F2/F3 keys)
macro index,pager <f2> '<sync-mailbox><enter-command>source ~/.config/neomutt/accounts/work-account.rc<enter><change-folder>!<enter>' "Switch to Work"
macro index,pager <f3> '<sync-mailbox><enter-command>source ~/.config/neomutt/accounts/personal-account.rc<enter><change-folder>!<enter>' "Switch to Personal"
```

## Usage

### Launch Neomutt

```bash
neomutt
```

On first launch:
- Neomutt will connect to your default Gmail account
- Folders will appear in the sidebar

### Key Bindings

#### Account Switching
Configure account switching macros in `neomuttrc` for quick access to your accounts.

#### Navigation
- `j/k` - Move up/down in list
- `Enter` - Open email
- `gg` - Go to first email
- `G` - Go to last email
- `/` - Search emails
- `n` - Next search result
- `N` - Previous search result

#### Sidebar
- `Ctrl+P` - Previous folder
- `Ctrl+N` - Next folder
- `Ctrl+O` - Open folder
- `B` - Toggle sidebar visibility

#### Email Actions
- `r` - Reply to sender
- `R` - Reply to all
- `a` - Archive (move to All Mail)
- `d` - Delete (IMAP delete)
- `f` - Forward
- `m` - Compose new email
- `V` - Open email in Gmail web interface (with full images/formatting)
- `B` - Open HTML email in browser
- `q` - Quit

#### Attachments
- `v` - View attachment list
- Navigate to attachment and press `Enter` to view
- Images will display using chafa (if in supported format)

### Viewing HTML Emails

HTML emails automatically render as text using elinks (felinks) with improved paragraph spacing for better readability.

**To view with full formatting and images:**
- Press `V` (Shift+v) to open the email in Gmail web interface
- Press `B` (Shift+b) to open the HTML in your default browser

**Alternative method:**
1. Press `v` to see attachments
2. Navigate to the HTML attachment
3. Press `Enter` to view in browser (or press `s` to save)

### Viewing Images

1. Open an email with image attachments
2. Press `v` to see attachment list
3. Navigate to the image
4. Press `Enter` - image displays using chafa with Kitty graphics protocol

**Note:** Images embedded in HTML emails appear as attachments, not inline.

## Troubleshooting

### Cannot Connect to Gmail

**Check IMAP is enabled:**
1. Gmail Settings → Forwarding and POP/IMAP
2. Verify IMAP is enabled

**Check OAuth2 token:**
```bash
# Test token for your account
python3 ~/.config/neomutt/scripts/mutt_oauth2.py \
  ~/.config/neomutt/tokens/YOUR_TOKEN_NAME.token
```

If this fails, regenerate the token:
```bash
# Re-authorize your account
python3 ~/.config/neomutt/scripts/mutt_oauth2.py \
  ~/.config/neomutt/tokens/YOUR_TOKEN_NAME.token \
  --verbose \
  --authorize \
  --provider google \
  --client-id YOUR_CLIENT_ID \
  --client-secret YOUR_CLIENT_SECRET \
  --email your-email@gmail.com
```

**Check network:**
```bash
# Test IMAP connection
openssl s_client -connect imap.gmail.com:993
```

### OAuth2 Authentication Issues

**Ensure Gmail API is enabled:**
1. Go to Google Cloud Console
2. Select your project
3. Check that Gmail API is enabled

**Token expired or invalid:**
- Tokens automatically refresh when expired
- If refresh fails, delete token file and re-authorize
```bash
rm ~/.config/neomutt/tokens/YOUR_TOKEN_NAME.token
# Then re-run authorization command from section 4 above
```

### Images Not Displaying

**Test chafa directly:**
```bash
# Download a test image and try viewing it
chafa --format=kitty --size=80x24 /path/to/test-image.jpg
```

**Check Ghostty graphics protocol support:**
- Ghostty supports Kitty graphics protocol
- Verify you're running neomutt directly in Ghostty (not in tmux, which may interfere)

**If images still don't work:**
- Open images externally: Press `v` for attachments, then `s` to save and open with Preview

### HTML Emails Look Bad

**Check elinks is installed:**
```bash
which elinks
# Should output: /opt/homebrew/bin/elinks
```

**Try opening in Gmail or browser:**
- Press `V` to open in Gmail web interface
- Press `B` to open HTML in your default browser

**For embedded images:**
Use `V` to open in Gmail, which will show all images and full formatting.

## File Structure

```
~/.config/neomutt/
├── neomuttrc                    # Main configuration
├── aliases                      # Manual contact aliases
├── accounts/
│   ├── .gitignore               # Git ignore rules
│   ├── example-account.rc       # Template for creating accounts
│   └── *-account.rc             # Your account configs (e.g., work-account.rc)
├── colors/
│   ├── bex-codes.rc             # Bex Codes color scheme (active)
│   └── catppuccin-mocha.rc      # Catppuccin Mocha (alternative)
├── credentials/
│   ├── .gitignore               # Ignores all credential files
│   └── client_secret.json       # Google OAuth2 credentials (git-ignored)
├── scripts/
│   ├── mutt_oauth2.py           # OAuth2 token refresh script
│   ├── open-in-gmail.sh         # Open email in Gmail web interface
│   ├── view-html.sh             # View HTML email in browser
│   └── elinks-dump.sh           # HTML renderer with paragraph spacing
├── tokens/
│   ├── .gitignore               # Ignores all token files
│   ├── README.md                # Token file documentation
│   ├── example.token.json       # Example token structure
│   └── *.token                  # OAuth2 tokens (git-ignored)
├── mailcap                      # MIME type handlers
└── README.md                    # This file

~/.lbdbrc                        # LBDB contact lookup configuration

~/.cache/neomutt/                # Cache (you create per account)
└── ACCOUNT_NAME/
    ├── headers/                 # Header cache
    └── messages/                # Message cache

~/.lbdb/                         # LBDB database (auto-created)
└── m_inmail.list                # Learned email addresses
```

## Security Notes

- **OAuth2 tokens git-ignored** - Refresh tokens never committed to version control
- **Account configs git-ignored** - Your actual email addresses are not committed to git
- **Example template provided** - Only `example-account.rc` is tracked in version control
- **TLS/SSL enforced** - All connections use encryption
- **Modern OAuth2 authentication** - More secure than app passwords
- **Automatic token refresh** - Tokens refresh automatically when expired
- **2FA still active** - OAuth2 doesn't bypass 2FA on your main account

### Git Ignore Setup

The git-ignore files ensure sensitive data never gets committed:

**`.config/neomutt/accounts/.gitignore`**:
- ✓ `example-account.rc` is tracked (generic template)
- ✗ All other `*-account.rc` files are NOT tracked (contain personal email addresses)

**`.config/neomutt/tokens/.gitignore`**:
- ✓ `.gitignore` itself is tracked
- ✗ ALL token files are NOT tracked (contain OAuth2 refresh tokens)

This means you can safely commit your neomutt configuration without exposing personal email addresses or authentication tokens.

## Resources

- [Neomutt Official Guide](https://neomutt.org/guide/)
- [1Password CLI Documentation](https://developer.1password.com/docs/cli/)
- [Gmail IMAP Settings](https://support.google.com/mail/answer/7126229)
- [Chafa Documentation](https://hpjansson.org/chafa/)

## Tips

### Running in tmux

If you use tmux, be aware that Kitty graphics protocol may not work inside tmux. Either:
1. Run neomutt outside tmux for image viewing
2. Use the browser fallback for HTML emails with images
3. Accept viewing images as external files (save and open in Preview)

### Search Performance

For faster searching across all emails, consider:
- Using Gmail's search: Press `a` to archive and search in [Gmail]/All Mail
- Setting up notmuch for local full-text search

### Multiple Signatures

Create signature files:
```bash
mkdir -p ~/.config/neomutt/signatures
echo "Your signature here" > ~/.config/neomutt/signatures/account1
echo "Your signature here" > ~/.config/neomutt/signatures/account2
```

Then uncomment the signature lines in account config files.

### Keyboard Shortcuts Cheat Sheet

Create a quick reference:
```bash
# In neomutt, press '?' to see all keybindings
```

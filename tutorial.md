# 📚 How to Share Your Program with Homebrew

This is a tutorial that teaches you how to put your program on Homebrew so others can easily install it.

## 🎯 What You'll Learn
- How to create GitHub Releases
- How to create a Homebrew Tap
- How to write a Homebrew Formula
- How to update your program

---

## 📋 Before You Start

You need to have:
- ✅ A GitHub account
- ✅ A program you've already written (like lscmd written in Rust)
- ✅ The `gh` command line tool installed

---

## 📦 Step 1: Create a GitHub Release

First, we need to package your program as a Release so others can download it.

```bash
# Create a release and upload your program file
gh release create v0.1.0 \
  --title "My Program v0.1.0" \
  --notes "First version released!" \
  ./target/release/your-program-name
```

**Simple explanation:**
- `v0.1.0` is the version number
- `--title` is the title for this version
- `--notes` explains what's new in this version

---

## 🏠 Step 2: Create a Homebrew Tap

A Homebrew Tap is like your program store where others can install your programs from.

```bash
# 1. Create a new GitHub repository (the name must be homebrew-tap)
gh repo create your-username/homebrew-tap --public --description "My Homebrew program collection"

# 2. Download the repository to your computer
git clone git@github.com:your-username/homebrew-tap.git
cd homebrew-tap

# 3. Create the Formula folder
mkdir -p Formula
```

**Why call it homebrew-tap?**
This is a Homebrew rule - the name must start with `homebrew-`.

---

## 📄 Step 3: Create a Formula File

A Formula is like an installation manual that tells Homebrew how to install your program.

### 3.1 First, get your program's SHA256 code

```bash
# Download your program file and calculate SHA256 (this is for security checking)
curl -sL https://github.com/your-username/your-program-name/archive/refs/tags/v0.1.0.tar.gz | shasum -a 256
```

You'll see a result like this:
```
c4d36863cea53a00dc2a7608ef539cfeff6c60b39851d46f32659ce02d6cf167  -
```

Write down this string of numbers!

### 3.2 Create the Formula file

In the `Formula` folder, create a file called `your-program-name.rb`:

```ruby
class YourProgramName < Formula
  desc "Simple description of your program"
  homepage "https://github.com/your-username/your-program-name"
  url "https://github.com/your-username/your-program-name/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "paste the SHA256 code from earlier here"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", "--locked", "--root", prefix, "--path", "."
  end

  test do
    assert_match "your-program-name", shell_output("#{bin}/your-program-name --version")
  end
end
```

**Explanation of each part:**
- `desc` - Simple description of your program
- `homepage` - Your program's webpage
- `url` - Download location for the source code
- `sha256` - Security check code
- `depends_on "rust"` - Says that Rust is needed to compile the program

---

## 🚀 Step 4: Upload to GitHub

```bash
# Add the file to git
git add Formula/your-program-name.rb

# Commit the changes
git commit -m "Add your-program-name installation recipe"

# Upload to GitHub
git push origin main
```

---

## 🎉 Step 5: Test Installation

Now others (including yourself) can install your program like this:

```bash
# Install your program
brew install your-username/tap/your-program-name

# Test if it worked
your-program-name --help
```

---

## 🔄 How to Update Your Program

When your program has a new version:

### 1. Create a new Release
```bash
gh release create v0.1.1 \
  --title "My Program v0.1.1" \
  --notes "Fixed some issues"
```

### 2. Update the Formula file
- Change the version number in the `url` to the new one (like v0.1.1)
- Recalculate and update the `sha256`
- Commit the changes to GitHub

### 3. Done!
Users can now use `brew upgrade` to update to the new version.

---

## 🗑️ How to Delete and Recreate a Release

Sometimes you need to delete a release to fix issues or recreate it. This is equivalent to force pushing:

```bash
# Delete the release and its files
gh release delete v0.1.0 -y

# Delete the git tag
git push origin --delete v0.1.0
```

**When to use this:**
- When you need to fix a broken release
- When you want to overwrite an existing version
- When there are issues with the uploaded files

**After deletion, you can create a new release with the same version number.**

---

## 🤔 Frequently Asked Questions

**Q: Why do we need SHA256?**
A: This ensures that the downloaded file hasn't been tampered with, protecting users' security.

**Q: What if my program isn't written in Rust?**
A: You can change `depends_on "rust"` to another language, or delete this line if no compilation is needed.

**Q: Are there any rules for Formula file names?**
A: The filename should match your program name, but with the first letter capitalized, for example `lscmd` becomes `Lscmd.rb`.

---

## 🎊 Congratulations!

You've learned how to share your program with Homebrew! Now Mac users worldwide can easily install your program.

Remember to:
- Update the Formula every time you update your program
- Write clear documentation
- Test the installation process to make sure everything works

Keep creating more awesome programs! 🚀
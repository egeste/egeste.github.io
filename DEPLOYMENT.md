# Deployment Guide with EXIF Processing

This site includes automated EXIF processing that requires ExifTool to be available during the build process. Here's how to deploy with different platforms.

## 🚨 Current Status: GitHub Pages

You're currently using **GitHub Pages** (`egeste.github.io`), which has limitations:

### ❌ **GitHub Pages Limitations**
- **No ExifTool** - System dependencies not available
- **Limited plugins** - Only allows approved Jekyll plugins
- **No custom build scripts** - Uses standard Jekyll build only

### ✅ **GitHub Pages Workarounds**

#### Option 1: GitHub Actions (Recommended)
Switch to **GitHub Actions** for building with **GitHub Pages** for hosting:

1. **Enable GitHub Actions deployment:**
   - Go to your repo: Settings → Pages
   - Source: "GitHub Actions" (instead of "Deploy from a branch")

2. **The workflow is ready:** `.github/workflows/deploy.yml`
   - Installs ExifTool automatically
   - Builds with EXIF processing
   - Deploys to GitHub Pages
   - Runs on every push to master/main

#### Option 2: Pre-process Locally
```bash
# Process images locally before committing
./build.sh --production
git add .
git commit -m "Update with processed images"
git push origin main
```

## 🚀 **Alternative Deployment Platforms**

### **Netlify** (Recommended Alternative)
✅ **Full EXIF processing support**

1. **Configuration ready:** `netlify.toml`
2. **Connect your GitHub repo** to Netlify
3. **Automatic deployments** with EXIF processing
4. **Custom domain support**
5. **Better performance** with CDN

**Setup:**
1. Sign up at [netlify.com](https://netlify.com)
2. Connect GitHub repo
3. Deploy settings are already configured in `netlify.toml`

### **Vercel**
✅ **EXIF processing support**

1. **Configuration ready:** `vercel.json`
2. **Connect GitHub repo** at [vercel.com](https://vercel.com)
3. **Automatic builds** with custom dependencies

### **DigitalOcean App Platform**
✅ **Full control over build environment**

```yaml
# .do/app.yaml
name: steve-regester-consulting
services:
- name: web
  source_dir: /
  github:
    repo: egeste/egeste.github.io
    branch: main
  run_command: ./build.sh --production && cd _site && python -m http.server 8080
  build_command: |
    apt-get update
    apt-get install -y libimage-exiftool-perl
    bundle install
  http_port: 8080
```

## 📊 **Deployment Comparison**

| Platform | EXIF Processing | Custom Domains | SSL | Performance | Cost |
|----------|----------------|-----------------|-----|-------------|------|
| **GitHub Pages (current)** | ❌ No | ✅ Yes | ✅ Yes | ⭐⭐⭐ | 🆓 Free |
| **GitHub Actions → Pages** | ✅ Yes | ✅ Yes | ✅ Yes | ⭐⭐⭐⭐ | 🆓 Free |
| **Netlify** | ✅ Yes | ✅ Yes | ✅ Yes | ⭐⭐⭐⭐⭐ | 🆓 Free tier |
| **Vercel** | ✅ Yes | ✅ Yes | ✅ Yes | ⭐⭐⭐⭐⭐ | 🆓 Free tier |
| **DigitalOcean** | ✅ Yes | ✅ Yes | ✅ Yes | ⭐⭐⭐⭐ | 💰 $5/month |

## 🎯 **Recommended Migration Path**

### **Immediate Solution (5 minutes)**
Enable GitHub Actions deployment:

1. **Go to GitHub repo** → Settings → Pages
2. **Change Source** from "Deploy from a branch" to "GitHub Actions"
3. **Push any change** - the workflow will run automatically
4. **EXIF processing will work** on all future deployments

### **Alternative: Netlify Migration (10 minutes)**
For better performance and features:

1. **Sign up** at [netlify.com](https://netlify.com)
2. **Connect GitHub repo**
3. **Deploy settings** are already configured
4. **Update DNS** to point to Netlify (optional)

## 🔧 **Testing Deployment**

### **Verify EXIF Processing**
After deployment, check if processing worked:

```bash
# Download an image from your deployed site
curl -o test-image.png https://your-site.com/assets/images/steve-regester-headshot.png

# Check metadata
exiftool test-image.png | grep "Steve Regester"
```

### **Build Logs**
Look for these messages in build logs:
- `EXIF Processor: Processing images...`
- `EXIF Processor: Successfully processed X images`
- `✅ EXIF metadata processing verified`

## 🚨 **Current Deployment Status**

**Your site is currently on GitHub Pages** which means:
- ❌ EXIF processing **does NOT run** on deployment
- ✅ Images have metadata from **local processing**
- 🔄 Need to **switch to GitHub Actions** for automatic processing

## 🎬 **Quick Setup: GitHub Actions**

1. **Enable in GitHub:**
   ```
   Your Repo → Settings → Pages → Source → GitHub Actions
   ```

2. **Push to trigger:**
   ```bash
   git add .
   git commit -m "Enable GitHub Actions deployment"
   git push origin main
   ```

3. **Monitor build:**
   - Go to "Actions" tab in your GitHub repo
   - Watch the deployment workflow run
   - Verify EXIF processing in logs

**Result:** Automatic EXIF processing on every deployment! 🎉

---

**Professional Jekyll Site**
Steve Regester - Technology Consulting & Engineering Leadership
https://egeste.net
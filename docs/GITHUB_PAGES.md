# GitHub Pages

RMGuard includes a static documentation site in `docs/`.

## Recommended Setup

Use GitHub Pages from the main branch:

1. Open the repository on GitHub.
2. Go to **Settings**.
3. Open **Pages**.
4. In **Build and deployment**, choose **Deploy from a branch**.
5. Select:
   - Branch: `main`
   - Folder: `/docs`
6. Save.

The site will be published at:

```text
https://happyuky7.github.io/RMGUARD-Linux/
```

## Why `/docs` Instead Of `gh-pages`?

For now, `/docs` keeps the website, FAQ, command reference, and release notes
next to the project source. A separate `gh-pages` branch can still be added
later if the website grows into a larger standalone site.

## Files

- `docs/index.html`: GitHub Pages homepage
- `docs/assets/site.css`: site styling
- `docs/assets/rmguard-logo.png`: generated RMGuard logo
- `docs/.nojekyll`: disables Jekyll processing

## Related Links

- Author website: https://happyuky7.github.io/
- Sponsor: https://github.com/sponsors/Happyuky7

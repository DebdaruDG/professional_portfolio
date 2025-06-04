
# 📄 Product Requirements Document (PRD)  
**Project Name:** Debdaru Dasgupta – Developer Portfolio  
**Platform:** Flutter Web  
**Data Source:** Dynamic JSON Model  
**Design Source of Truth:** Custom ColorPicker, Font Family, and Theme Data  

---

## 🧭 1. Objective

Create a professional, high-performance developer portfolio website using Flutter Web. The site should reflect technical skills, highlight projects, and serve as a portfolio that impresses recruiters and hiring managers. It must follow modern design principles, load fast, and work smoothly across all devices.

---

## 🏗️ 2. Layout Structure

### 🔹 Pages/Sections
- **Home (Landing Section)** – Name, tagline, short intro, CTA
- **About Me** – Bio, personal statement, resume download
- **Skills & Tech Stack** – Structured icons or chip list
- **Experience** – Timeline format, role description
- **Projects** – Cards with demo links, tech used, short description
- **Education** – Institution, degree, duration, CGPA
- **Contact** – Email form or direct links to social platforms

### 🔹 Navigation
- Fixed top navbar with anchors
- Hamburger menu on small screens
- Smooth scrolling to sections

### 🔹 Header/Footer
- Header with animated greeting (typing or glow effect)
- Footer with copyright, links, and GitHub

---

## 🔤 3. Typography Guidelines

| Element         | Font Style        | Weight | Size         |
|----------------|-------------------|--------|--------------|
| Titles/H1       | Custom Font (e.g., Sora, Inter, Manrope) | Bold   | 32–48 px     |
| Subtitles/H2    | Same Family       | SemiBold | 24–32 px     |
| Body Text       | Same Family       | Regular | 14–18 px     |
| Captions/Notes  | Sans-serif fallback | Light  | 12–14 px     |

- Font consistency: Use the same font family across the site for brand identity.
- Use spacing and line height: Line height around 1.5–1.7x for readability.

---

## 🎨 4. Color Palette & Harmony

Use your defined `ColorPicker` class with meaningful naming.

### Example Palette (CyberFusion)
| Color Use       | Hex        | Variable Name         |
|----------------|------------|------------------------|
| Primary         | `#D4FF00`  | `cyberYellow`         |
| Background      | `#000000`  | `cyberBlack`          |
| Card            | `#1A1A1A`  | `cyberCard`           |
| Accent          | `#FFFFFF`  | `cyberWhite`          |

**Best Practices:**
- Follow 60-30-10 rule: 60% base color, 30% secondary, 10% accent
- Maintain WCAG contrast ratios for accessibility

---

## 📱 5. Responsiveness

Use Flutter's responsive packages like `flutter_screenutil`, `layout_builder`, or `MediaQuery`.

| Device          | Width       | Behavior                 |
|----------------|-------------|--------------------------|
| Mobile         | < 600px     | Vertical scroll layout, stacked sections |
| Tablet         | 600–1024px  | 2-column layout for some sections |
| Desktop        | >1024px     | Grid layouts, full-width hero |

---

## ♿ 6. Accessibility Standards

- Semantic Widgets: `SelectableText`, `Semantics`, `Tooltip`
- Alt Text for images
- Keyboard navigation supported
- Contrast ratios maintained
- Color blindness-friendly palettes

---

## 📐 7. Visual Hierarchy & UX

- Use visual flow: Hero → Skills → Projects → Experience → Contact
- Use cards, icons, and whitespace to break content
- Highlight key elements with motion: fade in, scale, hover effects
- Project cards should have tags, GitHub & Live links
- CTA buttons should stand out

---

## 💼 8. Showcasing Skills & Projects Effectively

### Skills:
- Group by categories: Languages, Frameworks, Tools
- Use `GridView` or `Wrap`
- Optional: Animated progress bars

### Projects:
- Title, tags, short description
- Live demo & GitHub link
- Screenshot or preview

---

## 🧰 9. Tech Recommendations

- Flutter Web
- `provider` for theme management
- `go_router` or `auto_route` for navigation
- `flutter_gen` for assets
- Split themes via `ThemeData` and `ThemeProvider`
- JSON loading from `assets/data/portfolio.json`

---

## 📦 10. Folder Structure

```
lib/
├── main.dart
├── models/
│   └── portfolio_model.dart
├── providers/
│   └── theme_provider.dart
├── data/
│   └── portfolio.json
├── themes/
│   ├── color_picker.dart
│   ├── theme_light.dart
│   ├── theme_dark.dart
├── views/
│   ├── home.dart
│   ├── about.dart
│   ├── skills.dart
│   ├── projects.dart
│   ├── contact.dart
├── widgets/
│   ├── custom_app_bar.dart
│   ├── project_card.dart
│   ├── skill_chip.dart
```

---

## 🧩 11. Optional Enhancements

- Dark Mode toggle
- Custom Cursor for web
- Lottie animations or subtle canvas effects
- Floating contact button
- Blog or newsletter
- Theme persistence via SharedPreferences

---

## ✅ Final Outcome

Your site should:
- Reflect your personality and skills
- Load fast and work smoothly on all screens
- Impress recruiters with clean UX
- Be easy to maintain and extend

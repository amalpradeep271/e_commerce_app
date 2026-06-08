---
name: Modern Retail Collective
colors:
  surface: '#fdf7ff'
  surface-dim: '#ded8e0'
  surface-bright: '#fdf7ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f8f2fa'
  surface-container: '#f2ecf4'
  surface-container-high: '#ece6ee'
  surface-container-highest: '#e6e0e9'
  on-surface: '#1d1b20'
  on-surface-variant: '#494551'
  inverse-surface: '#322f35'
  inverse-on-surface: '#f5eff7'
  outline: '#7a7582'
  outline-variant: '#cbc4d2'
  surface-tint: '#6750a4'
  primary: '#4f378a'
  on-primary: '#ffffff'
  primary-container: '#6750a4'
  on-primary-container: '#e0d2ff'
  inverse-primary: '#cfbcff'
  secondary: '#63597c'
  on-secondary: '#ffffff'
  secondary-container: '#e1d4fd'
  on-secondary-container: '#645a7d'
  tertiary: '#765b00'
  on-tertiary: '#ffffff'
  tertiary-container: '#c9a74d'
  on-tertiary-container: '#503d00'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#e9ddff'
  primary-fixed-dim: '#cfbcff'
  on-primary-fixed: '#22005d'
  on-primary-fixed-variant: '#4f378a'
  secondary-fixed: '#e9ddff'
  secondary-fixed-dim: '#cdc0e9'
  on-secondary-fixed: '#1f1635'
  on-secondary-fixed-variant: '#4b4263'
  tertiary-fixed: '#ffdf93'
  tertiary-fixed-dim: '#e7c365'
  on-tertiary-fixed: '#241a00'
  on-tertiary-fixed-variant: '#594400'
  background: '#fdf7ff'
  on-background: '#1d1b20'
  surface-variant: '#e6e0e9'
typography:
  display-lg:
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-lg:
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-md:
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  title-lg:
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
  body-lg:
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-lg:
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.1px
  label-md:
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
  caption:
    fontSize: 11px
    fontWeight: '400'
    lineHeight: 14px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  xs: 4px
  sm: 8px
  md: 12px
  lg: 16px
  xl: 20px
  2xl: 24px
  3xl: 32px
  4xl: 40px
  5xl: 48px
---

## Brand & Style

The design system is engineered for a high-end, contemporary mobile shopping experience. It balances **Corporate Modern** efficiency with **Minimalist** clarity to ensure that product imagery remains the focal point while the interface provides a sophisticated, reliable structure.

The aesthetic is defined by a "Soft Utility" approach—combining the precision of a professional fintech app with the warmth and vibrancy of a lifestyle brand. The target audience expects a frictionless, premium journey that feels both technologically advanced and human-centric. The emotional response should be one of confidence, ease, and curated inspiration.

## Colors

This design system utilizes a dual-theme palette designed for high legibility and depth.

- **Primary (Deep Teal):** Used for key actions, branding elements, and active states. It signals stability and trust.
- **Secondary (Indigo):** Used for secondary interactions, categories, and subtle highlights.
- **Accent/CTA (Coral):** Reserved strictly for "Add to Cart," "Buy Now," and promotional urgency to drive conversion.
- **Surface Strategy:** In Light mode, surfaces use subtle grey tints to separate content blocks. In Dark mode, surfaces use a deep navy-slate to maintain depth without pure black crushing.

## Typography

The system uses **Be Vietnam Pro** (selected for its friendly yet professional geometric construction) across all levels. 

- **Hierarchy:** Use `display-lg` for hero marketing banners. `headline-lg` and `md` are reserved for product titles and section headers.
- **Body & Labels:** `body-lg` is the default for product descriptions. `label-lg` is specifically tuned for button text and navigation items to ensure clarity at small sizes.
- **Line Heights:** Generous line heights are maintained to ensure readability during long browsing sessions.

## Layout & Spacing

This is a mobile-first design system utilizing a **4px base grid**. 

- **Safe Zones:** A standard horizontal margin of `16px` (`lg`) is required for all screen edges.
- **Vertical Rhythm:** Use `24px` (`2xl`) to separate major content sections and `12px` (`md`) for internal component spacing (e.g., space between a product image and its title).
- **Grid:** For product listings, use a 2-column fluid grid with a `12px` gutter to maximize the number of products visible without overcrowding.

## Elevation & Depth

Visual hierarchy is achieved through a combination of **Tonal Layers** and **Ambient Shadows**.

- **Level 0 (Background):** Base layer (#FFFFFF or #0F172A).
- **Level 1 (Cards/Surface):** Primary content containers. In light mode, these use a subtle `1px` border and a soft shadow. In dark mode, depth is created primarily through color lightening (#1E293B).
- **Level 2 (Modals/Popups):** Elevated surfaces that use a more pronounced shadow (0 4px 6px) and a semi-transparent background overlay (dimmer) set to 40% opacity.
- **Shadow Philosophy:** Shadows are neutral and diffused. Avoid colored shadows unless specifically highlighting the Accent CTA button.

## Shapes

The design system employs a **Rounded** shape language to evoke a friendly and modern feel.

- **Cards:** The `16px` radius provides a soft, approachable container for product photography.
- **Interactive Elements:** Buttons (`12px`) and Inputs (`12px`) are slightly less rounded than cards to provide a clear functional distinction.
- **Pill Shapes:** Chips and Tags use a full `24px` radius to signify they are discrete, removable, or filterable elements.

## Components

### Buttons
- **Primary:** High-contrast Teal background with White text. Used for main flow progression.
- **Secondary:** Indigo tint or outlined Indigo. Used for secondary actions like "View Details".
- **CTA:** Orange/Coral background. Strictly reserved for "Add to Cart" or "Checkout".
- **Ghost:** No background, On-Surface-Variant text. Used for "Cancel" or "Dismiss".

### Inputs
- **Default State:** `1px` border (Border/Divider color), `12px` radius, Label-md above the field.
- **Focused:** Primary color border (Deep Teal) with a subtle `2px` outer glow.
- **Error:** Error red border and helper text.

### Navigation & App Bars
- **App Bar:** Centered title, `0` elevation on scroll (border-bottom only) to maintain a flat, modern appearance.
- **Bottom Navigation:** Fixed at bottom with a blur background. Active icons use the Primary color with a subtle dot indicator; inactive icons use On-Surface-Variant.

### Cards & Chips
- **Product Card:** `16px` radius, image-top layout, price in Primary color, and a small heart icon in the top-right for wishlisting.
- **Chips:** `24px` radius, background color at 10% opacity of the category color, with full-opacity text.
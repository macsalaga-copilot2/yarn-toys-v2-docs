# UI Card Component Documentation

## Source

The `Card` component and its subcomponents (`CardHeader`, `CardTitle`, `CardContent`, `CardFooter`) are based on the open-source [shadcn/ui](https://ui.shadcn.com/docs/components/card) library.  
They are located in:  
`src/components/ui/card.tsx`

## Import Example

```tsx
import { Card, CardHeader, CardTitle, CardContent, CardFooter } from "@/components/ui/card";
```

## Usage

- **Card**: Main container for the card.
- **CardHeader**: Section for the card's header (e.g., image or title).
- **CardTitle**: Title text within the header.
- **CardContent**: Main content area.
- **CardFooter**: Footer for actions or additional info.

### Example

```tsx
<Card>
  <CardHeader>
    <CardTitle>Product Title</CardTitle>
  </CardHeader>
  <CardContent>
    {/* Main content here */}
  </CardContent>
  <CardFooter>
    {/* Actions or info here */}
  </CardFooter>
</Card>
```

## Utility Function

The `cn` function is imported from `@/lib/utils` and is used to conditionally concatenate class names, making it easier to manage dynamic Tailwind CSS classes.

## File Naming Convention

- Documentation files are stored in the `/docs` directory at the project root.
- Use lowercase, dash-separated filenames describing the component or topic, e.g.:
  - `ui-card-component.md`
  - `centered-section-layout.md`
  - `product-card-shadcn.md`

---

_Last updated: 2025-07-
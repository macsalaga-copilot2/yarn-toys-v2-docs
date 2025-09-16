# API Routes Reference

**Purpose**: Quick reference for internal API endpoints  
**Last Updated**: August 15, 2025

## Available Endpoints

### `/api/products/latest`
**Method**: GET  
**Parameters**: 
- `limit` (query, optional, default: 6) - Number of products to return

**Response**: 
```json
{
  "products": Product[],
  "success": boolean
}
```

**Usage**: Homepage carousel

**Example**:
```bash
curl http://localhost:3000/api/products/latest?limit=4
```

---

### `/api/products`
**Method**: GET  
**Parameters**: None

**Response**: 
```json
{
  "products": Product[],
  "success": boolean
}
```

**Usage**: My-toys page product listing

**Example**:
```bash
curl http://localhost:3000/api/products
```

---

### `/api/products/[slug]`
**Method**: GET  
**Parameters**: 
- `slug` (URL parameter) - Product slug identifier

**Response**: 
```json
{
  "product": Product,
  "success": boolean
}
```

**Error Response** (404):
```json
{
  "error": "Product not found",
  "success": false
}
```

**Usage**: Individual product pages

**Example**:
```bash
curl http://localhost:3000/api/products/creamy-pink-sweater-bear-boy
```

## Error Handling

All endpoints return consistent error structure:

```json
{
  "error": "Error message",
  "success": false,
  "details": "Additional error details"
}
```

## Network Access

All endpoints work from both:
- Local: `http://localhost:3000/api/*`
- Network: `http://192.168.1.154:3000/api/*`

## Performance Notes

- Typical response time: 150-500ms
- No caching implemented yet (future enhancement)
- Direct Sanity queries on each request

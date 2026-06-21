# innovatech-frontend

Dashboard de Despachos Innovatech Chile - React + Vite + Nginx + Docker + CI/CD

## Tecnologías
- React 18 + Vite
- Nginx 1.25 (servidor web)
- Tailwind CSS
- Docker + Docker Compose
- GitHub Actions (CI/CD)

## Arquitectura
- Frontend en EC2 subred pública (puerto 80)
- Nginx hace proxy de /api hacia backend en subred privada (10.0.2.136:8081)
- Imágenes publicadas en Docker Hub
- Pipeline CI/CD: build → push → deploy automático en rama `deploy`

## Requisitos
- Docker instalado
- Node.js 20 (solo para desarrollo local)

## Ejecución local
```bash
npm install
npm run dev
```

## Con Docker
```bash
docker-compose up -d
```

## Pipeline CI/CD
El pipeline se activa con push a la rama `deploy`:
1. Construye la imagen Docker multi-stage (Node build + Nginx runtime)
2. Publica en Docker Hub
3. Despliega en EC2 Frontend via SSH

## Variables de entorno
| Variable | Descripción |
|---|---|
| VITE_API_URL | URL del backend API (default: http://localhost:8081) |

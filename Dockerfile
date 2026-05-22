# ============================================
# STAGE 1: BUILD - Compila la app React
# ============================================
FROM node:20-alpine AS builder

WORKDIR /build

COPY package*.json ./
RUN npm ci --silent

COPY . .

ARG VITE_API_URL=http://localhost:8081
ENV VITE_API_URL=$VITE_API_URL

RUN npm run build

# ============================================
# STAGE 2: RUN - Nginx sirve los archivos
# ============================================
FROM nginx:1.25-alpine AS runner

LABEL maintainer="Antonio Vivar - Innovatech Chile"
LABEL description="Frontend React Despachos - Innovatech Chile"

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/app.conf

COPY --from=builder /build/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
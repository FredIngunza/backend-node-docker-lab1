# ---------- Etapa de build ----------
FROM node:18 AS build
WORKDIR /app

# 1) Instala con devDependencies (necesario para compilar Nest/TypeScript)
COPY package*.json ./
RUN npm install

# 2) Copia código y compila a dist/
COPY . .
# Si tu script de build es distinto, ajusta esta línea (p. ej. "tsc -p tsconfig.build.json")
RUN npm run build

# 3) Quita devDependencies para runtime
RUN npm prune --omit=dev

# ---------- Etapa de runtime ----------
FROM node:18
WORKDIR /app

# Copiamos node_modules (ya sin dev) y artefactos compilados
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/dist ./dist
# Si tu app necesita otros archivos en runtime (config, package.json, etc), añádelos:
# COPY --from=build /app/package*.json ./

ENV PORT=3000
EXPOSE 3000

# Arranque sin depender del CLI de Nest
CMD ["node", "dist/main.js"]

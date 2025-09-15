# Laboratorio 1: Backend Node + MySQL en Docker Compose

Este laboratorio implementa un stack Node.js + MySQL usando Docker Compose.  
El objetivo es levantar un backend (NestJS) que expone un CRUD de usuarios con persistencia en MySQL.

---

## Imagen en GitHub Container Registry

La imagen pública está disponible en:


---

## ariables de entorno requeridas

El archivo .env NO debe subirse al repositorio.  
En su lugar, se provee un .env.example que documenta las variables necesarias:

# Aplicación
PORT=3000

# Base de datos
DB_HOST=db
DB_PORT=port
DB_NAME=dbname
DB_USER=dboser
DB_PASSWORD=dbpassword

# Bootstrap MySQL
MYSQL_ROOT_PASSWORD=wronpass
MYSQL_DATABASE=db
MYSQL_USER=labuser
MYSQL_PASSWORD=labpass

# Levantar los servicios:
docker compose up -d

# Verificar estado:
docker compose ps

# Inicialización de la base de datos
# Crear la tabla usuarios si no existe:

docker compose exec -T db mysql -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE" <<'SQL'
CREATE TABLE IF NOT EXISTS usuarios (
  id INT NOT NULL AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  edad INT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
);
SQL

# Pruebas de la API
# Crear usuario
curl -i -X POST http://localhost:3000/users \
  -H "Content-Type: application/json" \
  -d '{"nombre":"Carlos Lopez","edad":28}'

# Listar usuarios
curl http://localhost:3000/users

# Actualizar usuario
curl -i -X PATCH http://localhost:3000/users/1 \
  -H "Content-Type: application/json" \
  -d '{"edad":29}'

# Eliminar usuario
curl -i -X DELETE http://localhost:3000/users/1

# Consideraciones del laboratorio
- El nombre de la imagen de contenedor referencia al repositorio remoto en GitHub y es público para ser descargado.
- La imagen lleva el tag lab-1.
- Todas las instrucciones necesarias están documentadas en este README.md.
- No se subió ningún archivo .env, solo .env.example y esta documentación.
- No se modificó el código de la app, solo se agregaron los ficheros de infraestructura (Dockerfile, docker-compose.yml, .env.example).

# La revisión se hará ejecutando:
docker compose up

# Entregables
- Dockerfile
- docker-compose.yml
- .env.example (con estructura de variables)
- README.md (este archivo, con toda la documentación)

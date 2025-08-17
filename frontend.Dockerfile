FROM node:20-slim

WORKDIR /app
COPY frontend/package.json frontend/package-lock.json* /app/
RUN npm ci --no-audit --no-fund

COPY frontend/ /app
RUN npm run build

# Use Railway's PORT if provided
ENV PORT=3000
EXPOSE 3000
CMD bash -lc 'next start -p ${PORT:-3000}'

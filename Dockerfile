# Build server
FROM node:16
WORKDIR /app
COPY . .
RUN npm ci --production

# Set environment variables
ENV PORT=8080

# Listen on port 8080
EXPOSE 8080

# Start server
CMD ["node", "index.js"]

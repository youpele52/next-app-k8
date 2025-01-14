# alpine makes the image smaller
FROM node:18-alpine 

# disable telemetry
ENV NEXT_TELEMETRY_DISABLED=1
ENV PORT 80

WORKDIR /app

# copy everything
COPY . .

# Install pnpm
RUN npm install -g pnpm@9.5.0

# install but omit dev dependencies
# RUN npm install --omit=dev
RUN pnpm install --prod

RUN npm run build

# Add a group & user for nextjs
RUN addgroup --system --gid 1001 nextjs
RUN adduser --system --uid 1001 nextjs

# switch to nextjs user, not to run as root
USER nextjs

CMD ["pnpm", "run", "start"]
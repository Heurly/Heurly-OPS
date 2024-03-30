# Heurly-OPS 🚀

Welcome to Heurly-OPS! This repository serves as the central hub for deploying Heurly on our VPS (Virtual Private Server). Let's dive into its structure and deployment process.

## Structure 🏗️

The repository is organized into several folders, each representing a different stack:

- `postgres`: Contains configurations for the database.
- `logs`: Includes settings for Grafana monitoring.
- `main`: Used for production deployment.
- `beta`: Reserved for staging deployment.
- `traefik`: Manages the reverse proxy and Let's Encrypt certificates.

## Deployment 🚢

To deploy a stack, follow these steps:

1. Navigate to the desired folder (e.g., `logs`).
   ```bash
   cd logs
   ```

2. Ensure the environment file is complete by copying the example file.
   ```bash
   cp .env.example .env
   ```

3. Deploy the stack using Docker Swarm and the provided `docker-compose.yml`.
   ```bash
   docker stack deploy -c docker-compose.yml logs
   ```

After deployment, verify the running services using `docker stack ls`.

```bash
docker stack ls
```

This command should display the services and containers running for each stack.

## Updating a Service 🔧

To force update a service, use the following command:

```bash
docker service update --force stack-name_container
```

For instance, to force update the production app:

```bash
docker service update --force main_heurly
```

## Traefik 🛡️

Information about how Traefik works will be added soon. Stay tuned!

---

Feel free to explore and contribute to Heurly-OPS for better operational efficiency! If you have any questions or need further assistance, please reach out. Happy deploying! 😊✨
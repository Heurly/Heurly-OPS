Certainly! Below is a README on how to turn your Raspberry Pi into a self-hosted GitHub Actions runner:

---

# Setting up a Self-hosted GitHub Actions Runner on Raspberry Pi

### 1. Create a Directory and Navigate to it

```bash
mkdir actions-runner && cd actions-runner
```

### 2. Download the GitHub Actions Runner Package

```bash
curl -o actions-runner-linux-arm64-2.314.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.314.1/actions-runner-linux-arm64-2.314.1.tar.gz
```

### 3. Verify the Integrity of the Downloaded Package

```bash
echo "3d27b1340086115a118e28628a11ae727ecc6b857430c4b1b6cbe64f1f3b6789  actions-runner-linux-arm64-2.314.1.tar.gz" | shasum -a 256 -c
```

### 4. Extract the Downloaded Package

```bash
tar xzf ./actions-runner-linux-arm64-2.314.1.tar.gz
```

### 5. Run Configuration

Replace `{TOKEN}` with your GitHub repository's token.

```bash
./config.sh --url https://github.com/Heurly/Heurly --token {TOKEN}
```

### 6. Start the Runner

```bash
./run.sh
```

### Note:
- Make sure your Raspberry Pi is running and accessible when you want to utilize this self-hosted runner.
- The runner will be associated with your GitHub repository specified in the configuration step.
- Ensure that the token provided has sufficient permissions to execute the desired workflows in your repository.
- The `run.sh` script should be running continuously to keep the runner active.

### Usage in GitHub Actions Workflow:

In your workflow file (`github/workflows/main.yml`), you can specify that the job should run on your self-hosted runner:

```yaml
jobs:
  build:
    runs-on: self-hosted
```

---

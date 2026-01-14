#devops #software-engineering  #site-reliability-engineering #continuous-delivery #continuous-integration 
- <mark class="hltr-yellow">Continuous Integration</mark> (CI) is a software development practice where developers frequently merge code changes into a central repository, followed by automated builds and tests. <mark class="hltr-yellow">Continuous Delivery</mark> (CD) extends CI by automatically deploying all code changes to a testing or production environment after the build stage.
# Continuous Integration (CI)
## Core Concepts
- Continuous Integration focuses on automating the integration of code changes from multiple contributors into a single software project. The key principle is to integrate early and often to detect integration issues quickly.
### Key Practices
- **Frequent commits**: Developers commit code to the shared repository multiple times per day
- **Automated builds**: Every commit triggers an automated build process
- **Automated testing**: Build process includes running automated test suites
- **Fast feedback**: Developers receive immediate feedback on build and test failures
- **Fix broken builds immediately**: Broken builds are treated as highest priority
- **Maintain a single source repository**: All code resides in version control system
### CI Workflow
1. Developer commits code to version control system (Git, SVN)
2. CI server detects the change and triggers a build
3. Source code is compiled/transpiled
4. Automated tests are executed (unit, integration, static analysis)
5. Build artifacts are generated
6. Results are reported to the team
7. If failures occur, developers are notified immediately
# Continuous Delivery (CD)
## Core Concepts
- Continuous Delivery extends CI by ensuring that code is always in a deployable state. Every change that passes automated tests can be deployed to production with a manual approval step.
### Key Practices
- **Automated deployment pipeline**: All deployment steps are automated
- **Deployment to staging environments**: Changes are automatically deployed to test/staging
- **Production-like test environments**: Staging mirrors production configuration
- **Manual production deployment**: Final deployment requires human approval
- **Rollback capabilities**: Ability to quickly revert to previous versions
- **Configuration management**: Environment configurations are version-controlled
### CD vs Continuous Deployment
- **Continuous Delivery**: Automated deployment to staging, manual deployment to production
- **Continuous Deployment**: Fully automated deployment to production without manual intervention
- Most organizations practice Continuous Delivery with manual production gates for risk management and compliance requirements.
## CD Workflow
1. Code passes all CI stages (build, test)
2. Artifacts are packaged for deployment
3. Automated deployment to development environment
4. Smoke tests verify basic functionality
5. Automated deployment to staging environment
6. Integration and acceptance tests execute
7. Manual approval for production deployment
8. Automated deployment to production
9. Post-deployment verification tests
10. Monitoring and alerting track application health
# CI/CD Pipeline Stages
## 1. Source Stage
- Developer commits code to version control
- Webhook or polling triggers pipeline
- Code is checked out to build environment
```yaml title='GitHub Actions - Source Stage'
on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]
```
## 2. Build Stage
- Dependencies are installed
- Source code is compiled/transpiled
- Build artifacts are created
- Static code analysis runs

```groovy title='Jenkins - Build Stage'
stage('Build') {
    steps {
        sh 'npm install'
        sh 'npm run build'
        sh 'npm run lint'
    }
}
```
## 3. Test Stage

- Multiple levels of testing execute automatically:
    - **Unit tests**: Test individual components in isolation
    - **Integration tests**: Test component interactions
    - **Contract tests**: Verify API contracts between services
    - **Security tests**: Scan for vulnerabilities
    - **Code coverage**: Measure test coverage metrics
```yaml title='GitLab CI - Test Stage'
test:
  stage: test
  script:
    - npm run test:unit
    - npm run test:integration
    - npm run test:security
  coverage: '/Lines\s*:\s*(\d+\.\d+)%/'
```
## 4. Package Stage
- Build artifacts are packaged
- Docker images are built
- Version numbers are assigned
- Artifacts are published to registry
```dockerfile title='Docker Build Example'
FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY dist ./dist
EXPOSE 3000
CMD ["node", "dist/server.js"]
```
## 5. Deploy Stage

- Configuration is applied for target environment
- Database migrations execute
- Application is deployed
- Health checks verify successful deployment
```yaml title='Kubernetes Deployment'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api-server
spec:
  replicas: 3
  selector:
    matchLabels:
      app: api-server
  template:
    metadata:
      labels:
        app: api-server
        version: "1.2.3"
    spec:
      containers:
      - name: api
        image: registry.example.com/api-server:1.2.3
        ports:
        - containerPort: 3000
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
```
## 6. Verification Stage
- Smoke tests verify core functionality
- Integration tests run against deployed environment
- Performance tests measure response times
- Security scans check for runtime vulnerabilities
## 7. Monitoring Stage
- Application metrics are collected
- Logs are aggregated and indexed
- Alerts trigger on anomalies
- Dashboards display system health
# CI/CD Best Practices
## Pipeline Design
- **Keep pipelines fast**: Optimize for quick feedback (target under 10 minutes)
- **Fail fast**: Run quick tests first, expensive tests later
- **Parallel execution**: Run independent stages concurrently
- **Idempotent deployments**: Same deployment produces same result
- **Version everything**: Code, configuration, infrastructure, and pipeline definitions
## Testing Strategy
- **Pyramid approach**: Many unit tests, fewer integration tests, minimal E2E tests
- **Test data management**: Use realistic test data, anonymize production data
- **Environment parity**: Test environments mirror production
- **Automated testing**: Minimize manual testing requirements
- **Test isolation**: Tests should not depend on execution order
## Deployment Practices
- **Blue-green deployments**: Maintain two identical production environments
- **Canary releases**: Gradually roll out changes to subset of users
- **Feature flags**: Decouple deployment from feature release
- **Database migrations**: Backward-compatible schema changes
- **Rollback procedures**: Documented and tested rollback process
```javascript title='Feature Flag Example'
class FeatureFlags {
    constructor() {
        this.flags = new Map();
    }

    enable(featureName, userPredicate) {
        this.flags.set(featureName, userPredicate);
    }

    isEnabled(featureName, user) {
        if (!this.flags.has(featureName)) return false;
        const predicate = this.flags.get(featureName);
        return predicate(user);
    }
}

// Usage
const flags = new FeatureFlags();
flags.enable('new-checkout-flow', (user) => {
    // Canary release: 10% of users
    return user.id % 10 === 0;
});

if (flags.isEnabled('new-checkout-flow', currentUser)) {
    // Use new implementation
} else {
    // Use existing implementation
}
```
## Security Considerations
- **Secrets management**: Store credentials in secure vault, not in code
- **Dependency scanning**: Automatically check for vulnerable dependencies
- **Container scanning**: Scan Docker images for security issues
- **Access control**: Limit who can trigger deployments
- **Audit logging**: Track all pipeline executions and deployments

```yaml title='GitHub Actions - Secrets Management'
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Deploy to production
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          DATABASE_URL: ${{ secrets.DATABASE_URL }}
        run: |
          ./deploy.sh production
```
## Monitoring and Observability
- **Deployment tracking**: Correlate deployments with metrics changes
- **Error tracking**: Automatically report and aggregate errors
- **Performance monitoring**: Track response times, throughput, error rates
- **Log aggregation**: Centralize logs from all services
- **Alerting**: Notify team of deployment failures or performance degradation
# Complete Pipeline Example

```yaml title='Full CI/CD Pipeline - GitHub Actions'
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

env:
  NODE_VERSION: '18.x'
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  build:
    name: Build and Test
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Run linter
        run: npm run lint

      - name: Run unit tests
        run: npm run test:unit -- --coverage

      - name: Run integration tests
        run: npm run test:integration

      - name: Build application
        run: npm run build

      - name: Upload build artifacts
        uses: actions/upload-artifact@v3
        with:
          name: build-output
          path: dist/

  security:
    name: Security Scan
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Run security scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}

      - name: Run dependency audit
        run: npm audit --audit-level=moderate

  docker:
    name: Build Docker Image
    needs: [build, security]
    runs-on: ubuntu-latest
    if: github.event_name == 'push'
    permissions:
      contents: read
      packages: write
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Download build artifacts
        uses: actions/download-artifact@v3
        with:
          name: build-output
          path: dist/

      - name: Log in to Container Registry
        uses: docker/login-action@v2
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v4
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=sha,prefix={{branch}}-
            type=semver,pattern={{version}}

      - name: Build and push Docker image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}

  deploy-staging:
    name: Deploy to Staging
    needs: docker
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/develop'
    environment:
      name: staging
      url: https://staging.example.com
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Configure kubectl
        uses: azure/k8s-set-context@v3
        with:
          method: kubeconfig
          kubeconfig: ${{ secrets.KUBE_CONFIG_STAGING }}

      - name: Deploy to Kubernetes
        run: |
          kubectl set image deployment/api-server \
            api=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:develop-${{ github.sha }}
          kubectl rollout status deployment/api-server

      - name: Run smoke tests
        run: |
          npm run test:smoke -- --base-url=https://staging.example.com

  deploy-production:
    name: Deploy to Production
    needs: docker
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    environment:
      name: production
      url: https://example.com
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Configure kubectl
        uses: azure/k8s-set-context@v3
        with:
          method: kubeconfig
          kubeconfig: ${{ secrets.KUBE_CONFIG_PRODUCTION }}

      - name: Deploy to Kubernetes (Canary)
        run: |
          # Deploy canary with 10% traffic
          kubectl apply -f k8s/canary-deployment.yaml
          kubectl set image deployment/api-server-canary \
            api=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:main-${{ github.sha }}
          kubectl rollout status deployment/api-server-canary

      - name: Monitor canary metrics
        run: |
          # Wait and monitor error rates
          sleep 300
          ./scripts/check-metrics.sh

      - name: Promote to full deployment
        run: |
          kubectl set image deployment/api-server \
            api=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:main-${{ github.sha }}
          kubectl rollout status deployment/api-server
          kubectl delete deployment api-server-canary

      - name: Notify team
        uses: 8398a7/action-slack@v3
        with:
          status: ${{ job.status }}
          text: 'Production deployment completed: ${{ github.sha }}'
          webhook_url: ${{ secrets.SLACK_WEBHOOK }}
        if: always()
```

# Metrics and KPIs
## Key Performance Indicators
- **Deployment frequency**: How often are deployments to production occurring?
- **Lead time for changes**: Time from code commit to running in production
- **Mean time to recovery (MTTR)**: Time to restore service after incident
- **Change failure rate**: Percentage of deployments causing production failure
## DORA Metrics
- The DevOps Research and Assessment (DORA) team identified four key metrics that indicate software delivery performance:

| Performance Level | Deployment Frequency | Lead Time | MTTR | Change Failure Rate |
|------------------|---------------------|-----------|------|---------------------|
| Elite | Multiple per day | Less than 1 hour | Less than 1 hour | 0-15% |
| High | Once per week to once per month | 1 day to 1 week | Less than 1 day | 16-30% |
| Medium | Once per month to once per 6 months | 1 week to 1 month | 1 day to 1 week | 16-30% |
| Low | Fewer than once per 6 months | More than 1 month | More than 1 week | 16-30% |

## Monitoring Pipeline Health

```javascript title='Pipeline Metrics Collection'
class PipelineMetrics {
    constructor() {
        this.metrics = [];
    }

    recordPipelineRun(pipelineData) {
        const metric = {
            pipelineId: pipelineData.id,
            startTime: pipelineData.startTime,
            endTime: pipelineData.endTime,
            duration: pipelineData.endTime - pipelineData.startTime,
            status: pipelineData.status,
            stages: pipelineData.stages.map(stage => ({
                name: stage.name,
                duration: stage.duration,
                status: stage.status
            })),
            commit: pipelineData.commit,
            branch: pipelineData.branch
        };

        this.metrics.push(metric);
        this.sendToMonitoring(metric);
    }

    calculateDeploymentFrequency(days = 7) {
        const cutoff = Date.now() - (days * 24 * 60 * 60 * 1000);
        const recentDeployments = this.metrics.filter(m =>
            m.startTime > cutoff &&
            m.status === 'success' &&
            m.branch === 'main'
        );
        return recentDeployments.length / days;
    }

    calculateLeadTime() {
        // Time from first commit to deployment
        const deployments = this.metrics.filter(m =>
            m.status === 'success' &&
            m.branch === 'main'
        );

        const leadTimes = deployments.map(d => {
            // In practice, would query VCS for first commit time
            return d.duration;
        });

        return this.average(leadTimes);
    }

    calculateChangeFailureRate(days = 30) {
        const cutoff = Date.now() - (days * 24 * 60 * 60 * 1000);
        const recentDeployments = this.metrics.filter(m =>
            m.startTime > cutoff && m.branch === 'main'
        );

        const failures = recentDeployments.filter(m => m.status === 'failure');
        return failures.length / recentDeployments.length;
    }

    average(arr) {
        return arr.reduce((a, b) => a + b, 0) / arr.length;
    }

    sendToMonitoring(metric) {
        // Send to Prometheus, DataDog, etc.
        console.log('Sending metric:', metric);
    }
}
```
# CI/CD Maturity Model
## Level 1: Manual
- Manual builds and deployments
- Inconsistent processes
- No automated testing
- High deployment failure rate
## Level 2: Basic Automation
- Automated builds triggered by commits
- Basic automated testing (unit tests)
- Manual deployment process
- Some environment consistency
## Level 3: Continuous Integration
- Automated builds and comprehensive testing
- Fast feedback on failures
- Feature branches tested before merge
- Artifacts automatically generated
## Level 4: Continuous Delivery
- Automated deployments to staging
- Manual approval for production
- Rollback procedures in place
- Monitoring and alerting configured
## Level 5: Continuous Deployment
- Fully automated deployment to production
- Feature flags for risk management
- Advanced deployment strategies (canary, blue-green)
- Comprehensive observability
## Level 6: Optimized
- Self-service deployment platform
- ChatOps integration
- Predictive failure detection
- Automated remediation
- Continuous optimization of pipeline
***
# References
1. Continuous Delivery: Reliable Software Releases through Build, Test, and Deployment Automation - Jez Humble, David Farley - 2010 - Addison-Wesley Professional
    1. Chapter 2: Configuration Management
    2. Chapter 3: Continuous Integration
    3. Chapter 5: Anatomy of the Deployment Pipeline
    4. Chapter 10: Deploying and Releasing Applications
2. The DevOps Handbook: How to Create World-Class Agility, Reliability, and Security in Technology Organizations - Gene Kim, Jez Humble, Patrick Debois, John Willis - 2016 - IT Revolution Press
    1. Part III: The First Way - The Principles of Flow
    2. Part IV: The Second Way - The Principles of Feedback
3. Accelerate: The Science of Lean Software and DevOps - Nicole Forsgren, Jez Humble, Gene Kim - 2018 - IT Revolution Press
    1. Chapter 4: Technical Practices
    2. Chapter 13: DORA Metrics
4. https://martinfowler.com/articles/continuousIntegration.html - Martin Fowler's article on Continuous Integration
5. https://docs.github.com/en/actions - GitHub Actions Documentation
6. https://www.jenkins.io/doc/book/pipeline/ - Jenkins Pipeline Documentation
7. https://cloud.google.com/architecture/devops/devops-tech-continuous-integration - Google Cloud DevOps Research
8. https://www.atlassian.com/continuous-delivery/principles/continuous-integration-vs-delivery-vs-deployment - Atlassian CI/CD Guide

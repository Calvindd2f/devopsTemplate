# SonarQube integration

**Language** > **Specialist**: YAML > CI/CD Pipeline Configuration Specialist
**Includes**: GitHub Actions, SonarQube
**Requirements**: Knowledge of YAML syntax, familiarity with GitHub Actions and SonarQube

## Plan

1. Create a `.github/workflows` directory in your repository if it doesn't already exist.
2. Inside this directory, create a YAML file for your workflow.
3. Define the workflow triggers (e.g., on push, pull request).
4. Set up jobs to install prerequisites, run your build, and perform the SonarQube analysis.

## YAML Workflow Steps:

1. **Set Up Job**: Define the environment and set up necessary tools (like JDK for Java projects).
2. **Checkout Code**: Use the actions/checkout@v2 action to checkout the code.
3. **Set Up SonarQube**: Run SonarQube analysis using the SonarQube Scanner or the SonarCloud GitHub Action, depending on whether you are using SonarQube or SonarCloud.
4. **Additional Steps**: Any build or test steps necessary before running SonarQube analysis.
5. **SonarQube Analysis**: Run the analysis and specify the required SonarQube parameters, such as sonar.projectKey, sonar.organization, and sonar.sources.


Sample in `.github/workflow`

```yaml
name: CI with SonarQube

on: [push, pull_request]

jobs:
  build:
    name: Build and SonarQube Analysis
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v2
      
    - name: Set up JDK 11
      uses: actions/setup-java@v2
      with:
        java-version: '11'
        distribution: 'adopt'
        
    - name: Cache SonarQube packages
      uses: actions/cache@v2
      with:
        path: ~/.sonar/cache
        key: ${{ runner.os }}-sonar
        restore-keys: ${{ runner.os }}-sonar
    
    - name: SonarQube Scan
      uses: SonarSource/sonarqube-scan-action@v1.0.0
      with:
        args: >
          -Dsonar.projectKey=my_project_key
          -Dsonar.host.url=https://my.sonarqube.server
          -Dsonar.login=$SONAR_TOKEN
```
Replace `my_project_key`, `https://my.sonarqube.server`, and `$SONAR_TOKEN` with your project's specific values. 
The `$SONAR_TOKEN` should be stored in your repository's secrets.

**Source Tree**:

(💾=saved) .github/workflows/sonarqube.yml

function mkrepo {
	Param([Parameter(mandatory=$true)][string]$repo,
		[Parameter(mandatory=$true)][string]$sonarqube
		)

	cd "$HOME\Documents"
	mkdir $repo
	cd $repo
	
	mkdir src
	mkdir .build
	mkdir .github
	mkdir .github/workflows

	ni README.md
	ni .gitignore
	ni .editorconfig
	

	$editorconfig=@'
# EditorConfig is awesome: https://EditorConfig.org

# top-most EditorConfig file
root = true

[*]
indent_style = space
indent_size = 4
end_of_line = crlf
charset = utf-8
trim_trailing_whitespace = false
insert_final_newline = false
'@	
	echo $editorconfig > .editorconfig

	# if sonarqube switch is active
	if($sonar){
		$yml=".github/workflows/sonarqube.yml"
		ni $yml
		cd ".github\workflows\"
		#Define the workflow triggers (e.g., on push, pull request).
		# Set up jobs to install prerequisites, run your build, and perform the SonarQube analysis.
		if(test-path $yml){
		#YAML Workflow Steps:

		#Set Up Job: Define the environment and set up necessary tools (like JDK for Java projects).


		#Checkout Code: Use the actions/checkout@v2 action to checkout the code.


		#Set Up SonarQube: Run SonarQube analysis using the SonarQube Scanner or the SonarCloud GitHub Action, depending on whether you are using SonarQube or SonarCloud.

		#Additional Steps: Any build or test steps necessary before running SonarQube analysis.

		#SonarQube Analysis: Run the analysis and specify the required SonarQube parameters, such as sonar.projectKey, sonar.organization, and sonar.sources.


			$contents=@'
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

'@
		 echo $contents > $yml
		 }
		 }
		}

		#my_project_key					[var]
		#https://my.sonarqube.server	[var]
		#$SONAR_TOKEN					[secret]
 function mkrepo {
 Param([Parameter(mandatory=$true)][string]$repo,
 [Parameter(mandatory=$true)][switch]$sonarqube
 )

 cd "$HOME\Documents"
 mkdir $repo
 cd $repo

 mkdir src
 mkdir .build
 mkdir .github
 mkdir .github/workflows

 ni README.md
 ni .gitignore
 ni .editorconfig


 $editorconfig=@'
 # EditorConfig is awesome: https://EditorConfig.org

 # top-most EditorConfig file
 root = true

 [*]
 indent_style = space
 indent_size = 4
 end_of_line = crlf
 charset = utf-8
 trim_trailing_whitespace = false
 insert_final_newline = false
'@
echo $editorconfig > .editorconfig
# if sonarqube switch is active
if($sonarqube){
$yml=".github/workflows/sonarqube.yml"
ni $yml
cd ".github\workflows\"
}
$contents=@'
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

'@
echo $contents > $yml

<#				HELP
	 #Define the workflow triggers (e.g., on push, pull request).
	 # Set up jobs to install prerequisites, run your build, and perform the SonarQube analysis.

	 #YAML Workflow Steps:

	 #Set Up Job: Define the environment and set up necessary tools (like JDK for Java projects).


	 #Checkout Code: Use the actions/checkout@v2 action to checkout the code.


	 #Set Up SonarQube: Run SonarQube analysis using the SonarQube Scanner or the SonarCloud GitHub Action, depending on whether you are using SonarQube or SonarCloud.

	 #Additional Steps: Any build or test steps necessary before running SonarQube analysis.

	 #SonarQube Analysis: Run the analysis and specify the required SonarQube parameters, such as sonar.projectKey, sonar.organization, and sonar.sources.
#>
}
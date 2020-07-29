# MLExperiences
Machine learning experiences on jupyterlab

## See the results
You do not need to install anything to view the results, all of them are pushed on github, and it supports notebooks natively. So the results can be reviewed directly on github

## Launch the notebook
### Install
This project uses jupyter notebook. Everything is set up by the dockerfile. Scripts can help you build and launch everything

### Docker install
To install docker, follow the instructions here: https://docs.docker.com/get-docker/

### Build and launch by scripts
-   To build: ```./buildJupyterImage.sh```
-   To launch: ```./launchNotebookServer.sh```

### Open notebooks
Jupyter is a web app, to open your notebooks, open in your browser the following url:
http://localhost:8888/lab
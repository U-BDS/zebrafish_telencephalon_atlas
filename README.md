# A single-cell transcriptome atlas of the maturing zebrafish telencephalon
A R Shiny app of the transcriptome atlas of the maturing zebrafish telencephalon

<!-- TODO: ### Citation [once link is available] -->
<!-- TODO: Add sample figures of the app -->

# App deployment with Docker

The app, along with all dependencies have been containerized with Docker and is hosted in the following Docker Hub repository: <https://hub.docker.com/repository/docker/uabbds/zebrafish_telencephalon_atlas_app>

Overall, the user needs to 1. install Docker (Windows users: __please__ ensure you install Docker with admin privalages - `Run as administrator` option. [See more in the Docker docs](https://docs.docker.com/desktop/install/windows-install/). No issues expected in Macs or Linux) and 2. follow the instructions below for deployment.

## Deploy app locally

To run the container, run the following command:

```
docker run -d --rm --user shiny -p 3838:3838 -v ${PWD}:/var/log/shiny-server uabbds/zebrafish_telencephalon_atlas_app:latest
```

Open your browser, and go to the following localhost <http://localhost:3838/zebrafish_telencephalon_atlas_app/> ; it may take a minute for the app to fully load.

Once you are finished you may stop the container with:

```
docker ps # find docker container id
docker stop <container_id>
```

### Logs

The current working directory is mounted in the `docker run` command displayed above to save the logs from the app locally. Should you find an issue please see the log in the working directory (file with pattern `zebrafish_telencephalon_atlas_app-shiny-*.log`).

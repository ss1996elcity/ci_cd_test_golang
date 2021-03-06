FROM golang:alpine
WORKDIR /project_files
COPY tests_main.go /project_files
COPY Makefile /project_files
COPY main.go /project_files
COPY go.mod /project_files
RUN cd /project_files
RUN make mod_refresh build
ENTRYPOINT ["cd /project_files && make run"]

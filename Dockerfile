FROM golang:alpine
WORKDIR /project_files
COPY main_test.go /project_files
COPY Makefile /project_files
COPY main.go /project_files
COPY go.mod /project_files
RUN apt-get -y install make
RUN cd /project_files
RUN make mod_refresh build
ENTRYPOINT ["cd /project_files && make run"]

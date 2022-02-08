FROM golang:alpine
ENV SERVER_PORT_DEFAULT 8080
WORKDIR /project_files
COPY main_test.go /project_files
COPY Makefile /project_files
COPY main.go /project_files
COPY go.mod /project_files
#RUN apt-get -y install make
RUN cd /project_files
#RUN make mod_refresh build
RUN go mod tidy
RUN go build -o ./main ./
#RUN ./main 8080
#ENTRYPOINT ["/project_files/main 8080"]
CMD /project_files/main $SERVER_PORT_DEFAULT

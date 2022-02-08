FROM golang:alpine
ENV SERVER_PORT_DEFAULT 8080
WORKDIR /project_files
COPY main_test.go /project_files
COPY Makefile /project_files
COPY main.go /project_files
COPY go.mod /project_files
# Нет на этом дистрибутиве ни apt-get, ни make
#RUN apt-get -y install make
RUN cd /project_files
#RUN make mod_refresh build
RUN go mod tidy
RUN go build -o ./main ./
CMD /project_files/main $SERVER_PORT_DEFAULT

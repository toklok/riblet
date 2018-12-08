FROM golang:1.11.2 as builder

# install dep for package management
RUN go get -u github.com/golang/dep/cmd/dep

COPY .

ENTRYPOINT [ "go", "run", "main.go" ]
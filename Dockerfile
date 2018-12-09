# build stage
FROM golang:1.11.2 as build
WORKDIR /go/src/riblet

# install dependencies
COPY Gopkg.lock Gopkg.toml dep ./
RUN  ./dep ensure --vendor-only

# copy in source code and run tests
COPY . .
RUN go test ./... -cover -race

# build binary
RUN CGO_ENABLED=0 go build

FROM scratch
COPY --from=build /go/src/riblet/riblet ./riblet
ENTRYPOINT [ "./riblet" ]
#FROM quay.io/serhs/golang:1.4.2
FROM golang:1.5
#FROM golang:1.5.3-onbuild


# GPM
#RUN git clone https://github.com/pote/gpm.git && cd gpm && ./configure && make install && rm -rf /go/gpm
#RUN go get github.com/tools/godep
RUN go get gopkg.in/gcfg.v1


#ENV GOROOT /usr/src/go
ENV GOROOT /usr/local/go
#ENV GOROOT=/go
#ENV GOBIN $GOROOT/bin
ENV GOPATH=/go
ENV GOBIN $GOPATH/bin

# Add Godeps first-in-order to support dependency caching
#ADD com.serhs.util.dataservice/Godeps /go/
#RUN gpm install

# Add code
ADD golangservicetest /go/src/golangservicetest/golangservicetest
#ADD pi-comunicationslib /go/src/pi-comunicationslib

RUN cd /go/src/golangservicetest/golangservicetest && go clean && go build && go install
# Add Custom
#ADD assets/cfg/dsclientconfig.ini /.setup/
ADD assets/cfg/config.ini /.setup/
ADD assets/run.sh /


#Creamos el directorio de log
RUN mkdir -p /logs/
RUN chmod +x /run.sh
CMD /run.sh
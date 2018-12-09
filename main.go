package main

import "net"

func main() {
	runServer()
}

func runServer() {
	l, _ := net.Listen("tcp", ":80")
	go func() {
		defer func() {
			if r := recover(); r != nil {
				runServer()
			}
		}()
		for {
			c, err := l.Accept()
			if err == nil {
				go func(c net.Conn) {
					c.Write([]byte("riblet"))
				}(c)
			}
		}
	}()

}

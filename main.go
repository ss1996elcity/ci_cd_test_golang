package main

import (
	"fmt"
	"net"
	"net/http"
	"time"
	"log"
	"os"
)

func PrintGreet(name string) string {
	return fmt.Sprintf("%s, %s", "Hello", name)
}

func BaseHandler(w http.ResponseWriter, r *http.Request) {

	// CORS ======================================================================
	w.Header().Set("Content-Type",  "text/html; charset=ascii")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type,access-control-allow-origin, access-control-allow-headers")
	// CORS ======================================================================

	w.Write([]byte("Hello, World!"))
}

/* func Cors(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "text/html; charset=ascii")
	w.Header().Set("Access-Control-Allow-Origin", "*")
	w.Header().Set("Access-Control-Allow-Headers", "Content-Type,access-control-allow-origin, access-control-allow-headers")
	w.Write([]byte("Hello, World!"))
} */

func RunREST_API(port string) {
	sm := http.NewServeMux()
	//sm.HandleFunc("/string", ProcessPostString)
	//sm.HandleFunc("/send_file_from_post_request", ReceiveFile)

	sm.HandleFunc("/", BaseHandler)

	l, err := net.Listen("tcp4", port)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("%s\n", "Запущен http-сервер бекэнда...")
	time.Sleep(1 * time.Second)
	log.Fatal(http.Serve(l, sm))
}

func main() {

	if len(os.Args) < 2 {
		fmt.Println("Usage ./main <Port>")
		fmt.Println("For example: ./main  2021")
		os.Exit(1)
	}

	port := ":" + os.Args[1]
	go RunREST_API(port)
	time.Sleep(3 * time.Second)

	// Чтобы не городить WaitGroup'ы
	for {
	}

}

package main

import (
	"github.com/gin-gonic/gin"
	"net/http"
)

func main() {
	router := gin.Default()

	router.GET("/", func(c *gin.Context) {
		msg := "Hello, Welcome Gin World!"
		c.JSON(http.StatusOK, msg)
	})
	err := router.Run(":9000")
	if err != nil {
		panic(err)
	}
}

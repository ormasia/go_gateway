package http_proxy_router

import (
	"github.com/e421083458/go_gateway/controller"
	"github.com/e421083458/go_gateway/http_proxy_middleware"
	"github.com/e421083458/go_gateway/middleware"
	"github.com/gin-gonic/gin"
)

func InitRouter(middlewares ...gin.HandlerFunc) *gin.Engine {
	//todo 优化点1
	//router := gin.Default()
	router := gin.New()
	router.Use(middlewares...)
	router.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	oauth := router.Group("/oauth")
	oauth.Use(middleware.TranslationMiddleware())
	{
		controller.OAuthRegister(oauth)
	}

	router.Use(
		http_proxy_middleware.HTTPAccessModeMiddleware(),     // 服务匹配
		http_proxy_middleware.HTTPFlowCountMiddleware(),      // 流量统计
		http_proxy_middleware.HTTPFlowLimitMiddleware(),      // 流量限制
		http_proxy_middleware.HTTPJwtAuthTokenMiddleware(),   // JWT认证
		http_proxy_middleware.HTTPJwtFlowCountMiddleware(),   // JWT流量统计
		http_proxy_middleware.HTTPJwtFlowLimitMiddleware(),   // JWT流量限制
		http_proxy_middleware.HTTPWhiteListMiddleware(),      // 白名单
		http_proxy_middleware.HTTPBlackListMiddleware(),      // 黑名单
		http_proxy_middleware.HTTPHeaderTransferMiddleware(), // Header转换
		http_proxy_middleware.HTTPStripUriMiddleware(),       // URI剥离
		http_proxy_middleware.HTTPUrlRewriteMiddleware(),     // URL重写
		http_proxy_middleware.HTTPReverseProxyMiddleware(),   // 反向代理
	)

	return router
}

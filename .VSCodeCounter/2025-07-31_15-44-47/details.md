# Details

Date : 2025-07-31 15:44:47

Directory /workspaces/go_gateway

Total : 151 files,  14961 codes, 854 comments, 1448 blanks, all 17263 lines

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)

## Files
| filename | language | code | comment | blank | total |
| :--- | :--- | ---: | ---: | ---: | ---: |
| [Go\_Gateway\_技术分析文档.md](/Go_Gateway_%E6%8A%80%E6%9C%AF%E5%88%86%E6%9E%90%E6%96%87%E6%A1%A3.md) | Markdown | 643 | 0 | 128 | 771 |
| [README.md](/README.md) | Markdown | 291 | 3 | 84 | 378 |
| [SETUP\_COMPLETE.md](/SETUP_COMPLETE.md) | Markdown | 230 | 0 | 55 | 285 |
| [cert\_file/cert\_file.go](/cert_file/cert_file.go) | Go | 16 | 1 | 6 | 23 |
| [controller/admin.go](/controller/admin.go) | Go | 68 | 32 | 13 | 113 |
| [controller/admin\_login.go](/controller/admin_login.go) | Go | 57 | 23 | 9 | 89 |
| [controller/app.go](/controller/app.go) | Go | 202 | 66 | 15 | 283 |
| [controller/dashboard.go](/controller/dashboard.go) | Go | 102 | 27 | 8 | 137 |
| [controller/oauth.go](/controller/oauth.go) | Go | 71 | 25 | 10 | 106 |
| [controller/service.go](/controller/service.go) | Go | 652 | 120 | 64 | 836 |
| [dao/admin.go](/dao/admin.go) | Go | 43 | 0 | 7 | 50 |
| [dao/app.go](/dao/app.go) | Go | 106 | 1 | 15 | 122 |
| [dao/service.go](/dao/service.go) | Go | 109 | 6 | 11 | 126 |
| [dao/service\_access\_control.go](/dao/service_access_control.go) | Go | 46 | 0 | 7 | 53 |
| [dao/service\_grpc\_rule.go](/dao/service_grpc_rule.go) | Go | 42 | 0 | 7 | 49 |
| [dao/service\_http\_rule.go](/dao/service_http_rule.go) | Go | 47 | 0 | 7 | 54 |
| [dao/service\_info.go](/dao/service_info.go) | Go | 97 | 0 | 11 | 108 |
| [dao/service\_load\_balance.go](/dao/service_load_balance.go) | Go | 163 | 4 | 25 | 192 |
| [dao/service\_tcp\_rule.go](/dao/service_tcp_rule.go) | Go | 41 | 0 | 7 | 48 |
| [database\_setup.sh](/database_setup.sh) | Shell Script | 146 | 19 | 21 | 186 |
| [dist/index.html](/dist/index.html) | HTML | 1 | 0 | 0 | 1 |
| [dist/static/css/app.c068a7d0.css](/dist/static/css/app.c068a7d0.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-01bafe94.6d24dacd.css](/dist/static/css/chunk-01bafe94.6d24dacd.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-05a99c67.d0296c60.css](/dist/static/css/chunk-05a99c67.d0296c60.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-0c8f083f.42401dac.css](/dist/static/css/chunk-0c8f083f.42401dac.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-26ce89a6.c5f2d082.css](/dist/static/css/chunk-26ce89a6.c5f2d082.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-332e9546.d3b4ac8e.css](/dist/static/css/chunk-332e9546.d3b4ac8e.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-3c81f54c.a8e85e23.css](/dist/static/css/chunk-3c81f54c.a8e85e23.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-41ee40c0.b0fc6a10.css](/dist/static/css/chunk-41ee40c0.b0fc6a10.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-556562e8.b043920c.css](/dist/static/css/chunk-556562e8.b043920c.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-569050ae.b1d9f1ec.css](/dist/static/css/chunk-569050ae.b1d9f1ec.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-5838f4ce.6d24dacd.css](/dist/static/css/chunk-5838f4ce.6d24dacd.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-682aca40.2e87cc20.css](/dist/static/css/chunk-682aca40.2e87cc20.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-830154a6.93d95231.css](/dist/static/css/chunk-830154a6.93d95231.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/css/chunk-libs.3dfb7769.css](/dist/static/css/chunk-libs.3dfb7769.css) | PostCSS | 1 | 0 | 0 | 1 |
| [dist/static/js/app.ba29d09d.js](/dist/static/js/app.ba29d09d.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-01bafe94.9d413f88.js](/dist/static/js/chunk-01bafe94.9d413f88.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-04a4268a.724dc33c.js](/dist/static/js/chunk-04a4268a.724dc33c.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-05a99c67.c04f3707.js](/dist/static/js/chunk-05a99c67.c04f3707.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-0c8f083f.90d46a85.js](/dist/static/js/chunk-0c8f083f.90d46a85.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-14da9915.e5fd7e52.js](/dist/static/js/chunk-14da9915.e5fd7e52.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-26ce89a6.db1b4a55.js](/dist/static/js/chunk-26ce89a6.db1b4a55.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-2d230fe7.c0741423.js](/dist/static/js/chunk-2d230fe7.c0741423.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-332e9546.09da2fc6.js](/dist/static/js/chunk-332e9546.09da2fc6.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-3c81f54c.f8d2af0a.js](/dist/static/js/chunk-3c81f54c.f8d2af0a.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-41ee40c0.521e1d96.js](/dist/static/js/chunk-41ee40c0.521e1d96.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-556562e8.e2549da0.js](/dist/static/js/chunk-556562e8.e2549da0.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-569050ae.0a1a3715.js](/dist/static/js/chunk-569050ae.0a1a3715.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-5838f4ce.0efb8d1b.js](/dist/static/js/chunk-5838f4ce.0efb8d1b.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-682aca40.9076b38c.js](/dist/static/js/chunk-682aca40.9076b38c.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-830154a6.9479ea7f.js](/dist/static/js/chunk-830154a6.9479ea7f.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-elementUI.1f3a4f31.js](/dist/static/js/chunk-elementUI.1f3a4f31.js) | JavaScript | 1 | 0 | 0 | 1 |
| [dist/static/js/chunk-libs.1c62dbb0.js](/dist/static/js/chunk-libs.1c62dbb0.js) | JavaScript | 11 | 53 | 0 | 64 |
| [docker-compose.yml](/docker-compose.yml) | YAML | 121 | 5 | 8 | 134 |
| [docker-manage.sh](/docker-manage.sh) | Shell Script | 218 | 20 | 45 | 283 |
| [docker\_build.sh](/docker_build.sh) | Shell Script | 95 | 18 | 26 | 139 |
| [docs/docs.go](/docs/docs.go) | Go | 2,147 | 3 | 13 | 2,163 |
| [docs/swagger.json](/docs/swagger.json) | JSON | 2,095 | 0 | 0 | 2,095 |
| [docs/swagger.yaml](/docs/swagger.yaml) | YAML | 1,344 | 0 | 1 | 1,345 |
| [dto/admin.go](/dto/admin.go) | Go | 20 | 0 | 5 | 25 |
| [dto/admin\_login.go](/dto/admin_login.go) | Go | 21 | 0 | 6 | 27 |
| [dto/app.go](/dto/app.go) | Go | 65 | 0 | 13 | 78 |
| [dto/dashboard.go](/dto/dashboard.go) | Go | 16 | 0 | 3 | 19 |
| [dto/oauth.go](/dto/oauth.go) | Go | 18 | 0 | 4 | 22 |
| [dto/service.go](/dto/service.go) | Go | 168 | 0 | 27 | 195 |
| [go.mod](/go.mod) | XML | 33 | 0 | 3 | 36 |
| [go\_gateway.sql](/go_gateway.sql) | MS SQL | 235 | 121 | 57 | 413 |
| [golang\_common/lib/conf.go](/golang_common/lib/conf.go) | Go | 250 | 23 | 29 | 302 |
| [golang\_common/lib/file.go](/golang_common/lib/file.go) | Go | 52 | 7 | 10 | 69 |
| [golang\_common/lib/func.go](/golang_common/lib/func.go) | Go | 336 | 10 | 32 | 378 |
| [golang\_common/lib/log.go](/golang_common/lib/log.go) | Go | 115 | 4 | 20 | 139 |
| [golang\_common/lib/mysql.go](/golang_common/lib/mysql.go) | Go | 201 | 11 | 21 | 233 |
| [golang\_common/lib/redis.go](/golang_common/lib/redis.go) | Go | 103 | 1 | 6 | 110 |
| [golang\_common/log/config.go](/golang_common/log/config.go) | Go | 70 | 0 | 15 | 85 |
| [golang\_common/log/console\_writer.go](/golang_common/log/console_writer.go) | Go | 49 | 0 | 14 | 63 |
| [golang\_common/log/file\_writer.go](/golang_common/log/file_writer.go) | Go | 169 | 3 | 38 | 210 |
| [golang\_common/log/log.go](/golang_common/log/log.go) | Go | 240 | 3 | 50 | 293 |
| [golang\_common/log/log\_test.go](/golang_common/log/log_test.go) | Go | 26 | 1 | 2 | 29 |
| [grpc\_proxy\_middleware/grpc\_black\_list.go](/grpc_proxy_middleware/grpc_black_list.go) | Go | 40 | 1 | 3 | 44 |
| [grpc\_proxy\_middleware/grpc\_flow\_count.go](/grpc_proxy_middleware/grpc_flow_count.go) | Go | 26 | 0 | 4 | 30 |
| [grpc\_proxy\_middleware/grpc\_flow\_limit.go](/grpc_proxy_middleware/grpc_flow_limit.go) | Go | 49 | 0 | 3 | 52 |
| [grpc\_proxy\_middleware/grpc\_header\_transfer.go](/grpc_proxy_middleware/grpc_header_transfer.go) | Go | 37 | 1 | 3 | 41 |
| [grpc\_proxy\_middleware/grpc\_jwt\_auth\_token.go](/grpc_proxy_middleware/grpc_jwt_auth_token.go) | Go | 47 | 1 | 3 | 51 |
| [grpc\_proxy\_middleware/grpc\_jwt\_flow\_count.go](/grpc_proxy_middleware/grpc_jwt_flow_count.go) | Go | 44 | 0 | 4 | 48 |
| [grpc\_proxy\_middleware/grpc\_jwt\_flow\_limit.go](/grpc_proxy_middleware/grpc_jwt_flow_limit.go) | Go | 56 | 0 | 4 | 60 |
| [grpc\_proxy\_middleware/grpc\_test.go](/grpc_proxy_middleware/grpc_test.go) | Go | 12 | 2 | 3 | 17 |
| [grpc\_proxy\_middleware/grpc\_white\_list.go](/grpc_proxy_middleware/grpc_white_list.go) | Go | 36 | 1 | 4 | 41 |
| [grpc\_proxy\_router/grpcserver.go](/grpc_proxy_router/grpcserver.go) | Go | 62 | 0 | 7 | 69 |
| [http\_proxy\_middleware/http\_access\_mode.go](/http_proxy_middleware/http_access_mode.go) | Go | 18 | 2 | 3 | 23 |
| [http\_proxy\_middleware/http\_black\_list.go](/http_proxy_middleware/http_black_list.go) | Go | 37 | 1 | 5 | 43 |
| [http\_proxy\_middleware/http\_flow\_count.go](/http_proxy_middleware/http_flow_count.go) | Go | 34 | 5 | 6 | 45 |
| [http\_proxy\_middleware/http\_flow\_limit.go](/http_proxy_middleware/http_flow_limit.go) | Go | 51 | 0 | 4 | 55 |
| [http\_proxy\_middleware/http\_header\_transfer.go](/http_proxy_middleware/http_header_transfer.go) | Go | 32 | 1 | 3 | 36 |
| [http\_proxy\_middleware/http\_jwt\_auth\_token.go](/http_proxy_middleware/http_jwt_auth_token.go) | Go | 44 | 7 | 4 | 55 |
| [http\_proxy\_middleware/http\_jwt\_flow\_count.go](/http_proxy_middleware/http_jwt_flow_count.go) | Go | 32 | 0 | 3 | 35 |
| [http\_proxy\_middleware/http\_jwt\_flow\_limit.go](/http_proxy_middleware/http_jwt_flow_limit.go) | Go | 35 | 0 | 3 | 38 |
| [http\_proxy\_middleware/http\_reverse\_proxy.go](/http_proxy_middleware/http_reverse_proxy.go) | Go | 35 | 5 | 4 | 44 |
| [http\_proxy\_middleware/http\_strip\_uri.go](/http_proxy_middleware/http_strip_uri.go) | Go | 24 | 5 | 5 | 34 |
| [http\_proxy\_middleware/http\_url\_rewrite.go](/http_proxy_middleware/http_url_rewrite.go) | Go | 33 | 5 | 3 | 41 |
| [http\_proxy\_middleware/http\_white\_list.go](/http_proxy_middleware/http_white_list.go) | Go | 33 | 1 | 4 | 38 |
| [http\_proxy\_router/httpserver.go](/http_proxy_router/httpserver.go) | Go | 62 | 2 | 7 | 71 |
| [http\_proxy\_router/route.go](/http_proxy_router/route.go) | Go | 35 | 2 | 6 | 43 |
| [k8s\_dashboard.yaml](/k8s_dashboard.yaml) | YAML | 100 | 0 | 0 | 100 |
| [k8s\_deploy.sh](/k8s_deploy.sh) | Shell Script | 179 | 21 | 44 | 244 |
| [k8s\_server.yaml](/k8s_server.yaml) | YAML | 145 | 0 | 0 | 145 |
| [main.go](/main.go) | Go | 61 | 2 | 11 | 74 |
| [middleware/ip\_auth.go](/middleware/ip_auth.go) | Go | 23 | 0 | 3 | 26 |
| [middleware/recovery.go](/middleware/recovery.go) | Go | 30 | 2 | 2 | 34 |
| [middleware/request\_log.go](/middleware/request_log.go) | Go | 52 | 4 | 10 | 66 |
| [middleware/response.go](/middleware/response.go) | Go | 54 | 1 | 12 | 67 |
| [middleware/session\_auth.go](/middleware/session_auth.go) | Go | 18 | 0 | 3 | 21 |
| [middleware/translation.go](/middleware/translation.go) | Go | 152 | 10 | 9 | 171 |
| [nginx.conf](/nginx.conf) | Properties | 79 | 10 | 19 | 108 |
| [onekeysynccode.sh](/onekeysynccode.sh) | Shell Script | 14 | 2 | 1 | 17 |
| [onekeyupdate.sh](/onekeyupdate.sh) | Shell Script | 8 | 1 | 1 | 10 |
| [public/const.go](/public/const.go) | Go | 25 | 0 | 8 | 33 |
| [public/flow\_count\_handler.go](/public/flow_count_handler.go) | Go | 34 | 0 | 8 | 42 |
| [public/flow\_limit\_handler.go](/public/flow_limit_handler.go) | Go | 42 | 0 | 9 | 51 |
| [public/jwt.go](/public/jwt.go) | Go | 23 | 0 | 4 | 27 |
| [public/log.go](/public/log.go) | Go | 60 | 8 | 9 | 77 |
| [public/params.go](/public/params.go) | Go | 53 | 2 | 5 | 60 |
| [public/redis.go](/public/redis.go) | Go | 25 | 0 | 4 | 29 |
| [public/redis\_flow\_count.go](/public/redis_flow_count.go) | Go | 90 | 1 | 11 | 102 |
| [public/util.go](/public/util.go) | Go | 33 | 1 | 5 | 39 |
| [reverse\_proxy/grcp\_reverse\_proxy.go](/reverse_proxy/grcp_reverse_proxy.go) | Go | 25 | 0 | 3 | 28 |
| [reverse\_proxy/http\_reverse\_proxy.go](/reverse_proxy/http_reverse_proxy.go) | Go | 56 | 28 | 7 | 91 |
| [reverse\_proxy/load\_balance/check\_config.go](/reverse_proxy/load_balance/check_config.go) | Go | 87 | 7 | 9 | 103 |
| [reverse\_proxy/load\_balance/config.go](/reverse_proxy/load_balance/config.go) | Go | 10 | 1 | 3 | 14 |
| [reverse\_proxy/load\_balance/config\_test.go](/reverse_proxy/load_balance/config_test.go) | Go | 19 | 0 | 2 | 21 |
| [reverse\_proxy/load\_balance/consistent\_hash.go](/reverse_proxy/load_balance/consistent_hash.go) | Go | 85 | 9 | 17 | 111 |
| [reverse\_proxy/load\_balance/consistent\_hash\_test.go](/reverse_proxy/load_balance/consistent_hash_test.go) | Go | 20 | 2 | 4 | 26 |
| [reverse\_proxy/load\_balance/factory.go](/reverse_proxy/load_balance/factory.go) | Go | 56 | 1 | 5 | 62 |
| [reverse\_proxy/load\_balance/interface.go](/reverse_proxy/load_balance/interface.go) | Go | 6 | 1 | 3 | 10 |
| [reverse\_proxy/load\_balance/random.go](/reverse_proxy/load_balance/random.go) | Go | 42 | 8 | 8 | 58 |
| [reverse\_proxy/load\_balance/random\_test.go](/reverse_proxy/load_balance/random_test.go) | Go | 22 | 0 | 4 | 26 |
| [reverse\_proxy/load\_balance/round\_robin.go](/reverse_proxy/load_balance/round_robin.go) | Go | 46 | 8 | 8 | 62 |
| [reverse\_proxy/load\_balance/round\_robin\_test.go](/reverse_proxy/load_balance/round_robin_test.go) | Go | 22 | 0 | 4 | 26 |
| [reverse\_proxy/load\_balance/weight\_round\_robin.go](/reverse_proxy/load_balance/weight_round_robin.go) | Go | 67 | 13 | 11 | 91 |
| [reverse\_proxy/load\_balance/weight\_round\_robin\_test.go](/reverse_proxy/load_balance/weight_round_robin_test.go) | Go | 25 | 0 | 4 | 29 |
| [reverse\_proxy/tcp\_reverse\_proxy.go](/reverse_proxy/tcp_reverse_proxy.go) | Go | 93 | 4 | 13 | 110 |
| [router/httpserver.go](/router/httpserver.go) | Go | 37 | 0 | 4 | 41 |
| [router/route.go](/router/route.go) | Go | 83 | 35 | 22 | 140 |
| [start\_gateway.sh](/start_gateway.sh) | Shell Script | 36 | 2 | 7 | 45 |
| [tcp\_proxy\_middleware/tcp\_black\_list.go](/tcp_proxy_middleware/tcp_black_list.go) | Go | 39 | 1 | 6 | 46 |
| [tcp\_proxy\_middleware/tcp\_flow\_count.go](/tcp_proxy_middleware/tcp_flow_count.go) | Go | 31 | 1 | 5 | 37 |
| [tcp\_proxy\_middleware/tcp\_flow\_limit.go](/tcp_proxy_middleware/tcp_flow_limit.go) | Go | 54 | 0 | 5 | 59 |
| [tcp\_proxy\_middleware/tcp\_slice\_router.go](/tcp_proxy_middleware/tcp_slice_router.go) | Go | 95 | 11 | 20 | 126 |
| [tcp\_proxy\_middleware/tcp\_white\_list.go](/tcp_proxy_middleware/tcp_white_list.go) | Go | 35 | 1 | 4 | 40 |
| [tcp\_proxy\_router/tcpserver.go](/tcp_proxy_router/tcpserver.go) | Go | 59 | 2 | 10 | 71 |
| [tcp\_server/tcp\_conn.go](/tcp_server/tcp_conn.go) | Go | 49 | 1 | 9 | 59 |
| [tcp\_server/tcp\_server.go](/tcp_server/tcp_server.go) | Go | 126 | 1 | 17 | 144 |

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)
FROM node:20.0.0-alpine3.17 AS build

# npm 访问国外比较慢，设置淘宝源加速
RUN npm config set registry https://registry.npm.taobao.org

# 安装 hexo
RUN npm install -g hexo-cli
RUN npm install -g hexo

# 初始化博客，安装 stellar 主题
RUN hexo init output && \
    rm -rf output/source/_posts/hello-world.md && \
    cd output && npm install hexo-theme-stellar && npm install

COPY asset asset
COPY hexo hexo
COPY markdown markdown

# 拷贝文章到 hexo 目录
RUN { \
      for path in $(find markdown -type f -name "*.md"); do \
	    cp ${path} output/source/_posts; \
	  done \
    } && \
    cp hexo/* output && \
	mkdir -p output/source/images && \
	cp asset/* output/source/images

# 生成静态文件
RUN cd output && hexo generate

FROM nginx:1.24

# 拷贝静态文件到 nginx 中
COPY --from=build /output/public /usr/share/nginx/html

OUTPUT=output

init:
	hexo init ${OUTPUT}
	cd ${OUTPUT} && npm i hexo-theme-stellar && npm i

.PHONY: update
update:
	for path in $$(find markdown -type f -name "*.md"); do \
	  cp $${path} ${OUTPUT}/source/_posts; \
	done;
	cp hexo/* ${OUTPUT}
	mkdir -p ${OUTPUT}/source/images
	cp asset/* ${OUTPUT}/source/images

make run:
	cd ${OUTPUT} && hexo server

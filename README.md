# Daniel Lim Resumes

## (and Markdown Resume Generator Theme: Modern2)   

Resume for Daniel Lim, plus a heavily modified version of the `modern` theme for the [Markdown Resume Generator](https://github.com/there4/markdown-resume)

## Usage

### Build Container

Nothing special about building the Docker container.

```bash
docker build -t markdown-resume .
```

### Enter Container

The following is for starting the container on a Windows box, where the host machine uses Windows paths but the guest uses Linux paths. On a Linux based host, the volumes should be changed to use Linux paths as well.
	
```bash
docker run -it \
	--name markdown-resume \
	-v "c:\Users\Daniel\Documents\resume":/resume \
	-v "c:\Users\Daniel\Documents\resume\template":/app/templates/modern2 \
	markdown-resume
```

### Build Doc

```bash
md2resume pdf -k \
	--pdfargs="--dpi 300 -s Letter -T 1in -B 1in -L 1in -R 1in --print-media-type" \
	-t modern2 \
	./src/geosite.md ./
```


# monochrome-image-converter
Create an abstract data type that will store a monochrome image.

- The program calls create_image with the width and height of the image.
- The function set_pixel is called for every pixel in the image to set them to a gray value.
- The function get_pixel is called for every pixel in the image to read the gray value for saving.
- The program calls destroy_image to free the allocated memory.

executing it with this command:
~~~
./blocky sparty.png sparty-m.png
~~~

will produce the monochrome version of the image sparty.png:
![Alt text](https://facweb.cse.msu.edu/cbowen/cse320/system9/img/sparty-m.png)

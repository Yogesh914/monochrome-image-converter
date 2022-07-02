.data
//   
// The image data structure
//
.equ    image_wid, 0
.equ    image_hit, 4
.equ    image_array, 8
.equ    image_size, 16

//
// The image pixel data structure
// This is the contents of a location in the array
//
.equ    pixel_value, 0
.equ    pixel_size, 8

.text
 
.global create_image
//
// void *create_image(int wid, int hit)
// Create an image ADT and return it.
//
create_image:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!
    stp x21, x22, [sp, #-16]!

    mov w19, w0   // width
    mov w20, w1   // height

    mov w0, #1
    mov w1, #image_size
    bl calloc     // allocate

    //
    // Set the data structure initial values
    //

    str w19, [x0, #image_wid]
    str w20, [x0, #image_hit]

    mov x21, x0   // image pointer
    
    //
    // Alocate the image array
    //

    mul w0, w19, w20      // width * height
    mov w1, #pixel_size
    bl calloc

    str x0, [x21, #image_array]

    mov x0, x21

create_image_done:
    ldp x21, x22, [sp], #16
    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
    
.global destroy_image   
//
// void destroy_image(void *image)
// Destroy image, freeing memory
//
destroy_image:
    stp x29, x30, [sp, #-16]!
    stp x19, x20, [sp, #-16]!

    mov x19, x0

    ldr x0, [x19,#image_array]
    bl free

    mov x0, x19
    bl free

    ldp x19, x20, [sp], #16
    ldp x29, x30, [sp], #16
    ret
    
.global get_width
//
// int get_width(void *image)
// Get the width of the image
//
get_width:
    ldr w0,[x0,#image_wid]
    ret
    
.global get_height
//
// int get_height(void *image)
// Get the height of the image
//
get_height:
    ldr w0, [x0, #image_hit]
    ret
    
        
.global set_pixel
//
// void set_pixel(void *image, int row, int col, double value)
//
set_pixel:
    
    ldr w3, [x0, #image_wid]
    
    //Point to the begining 
    ldr x4, [x0, #image_array]
    mul w3, w1, w3
    add w3, w3, w2
    mov w5, #pixel_size
    mul w3, w3, w5
    //Add offset
    add x4, x4, w3, uxtw 
    
    str d0, [x4, #pixel_value]

    ret

.global get_pixel
//
// double get_pixel(void *image, int row, int col)
//
get_pixel:
	  ldr d0, =0
    
    ldr w3, [x0, #image_wid]

    //Point to the begining
    ldr x4, [x0, #image_array]
    mul w3, w1, w3
    add w3, w3, w2
    mov w5, #pixel_size
    mul w3, w3, w5
    add x4, x4, w3, uxtw

    ldr d0, [x4, #pixel_value]

    ret

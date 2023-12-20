#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/delay.h>

MODULE_LICENSE("JOSH");
static int just_printk_init(void)
{
    printk(KERN_INFO"%s: This is just a printk in init\n", __func__);
    return 0;
}

static void just_printk_exit(void)
{
    printk(KERN_INFO"%s: This is just a printk in exit\n", __func__);
}

module_init(just_printk_init);
module_exit(just_printk_exit);

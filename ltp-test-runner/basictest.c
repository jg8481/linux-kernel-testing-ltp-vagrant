#include "tst_test.h"
#include <stdio.h>
#include <unistd.h>


static void testsetup(void)
{
	char cwd[PATH_MAX];
	printf("This is Test Setup\n");
	if (getcwd(cwd, sizeof(cwd)) != NULL) {
		printf("Current working dir: %s\n", cwd);
	} else {
		perror("getcwd() error");
	}
}

static void basictest(void)
{
	char cwd[PATH_MAX];
        tst_res(TPASS, "This Basic Test passed");
	if (getcwd(cwd, sizeof(cwd)) != NULL) {
		printf("Current working dir: %s\n", cwd);
	} else {
		perror("getcwd() error");
	}
}

static void testteardown(void)
{
	char cwd[PATH_MAX];
	printf("This is Test Teardown\n");
	if (getcwd(cwd, sizeof(cwd)) != NULL) {
		printf("Current working dir: %s\n", cwd);
	} else {
		perror("getcwd() error");
	}
}

static struct tst_test test = {
        .test_all = basictest,
	.setup = testsetup,
	.cleanup = testteardown,
	.needs_tmpdir = 1,
};


try {
    try {
        throw new Error("oops");
    } catch (ex) {
        console.error("inner", ex.message);
        throw ex;
    } finally {
        console.log("finally");
    }
} catch (ex) {
    console.error("outer", ex.message);
}
!function(a) {
    console.log(a);
}(1)

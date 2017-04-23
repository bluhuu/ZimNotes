try {
   try {
        throw new Error("oops");
   } finally {
       console.log("finally");
   }
} catch (ex) {
    console.error("outer",ex.message);
}

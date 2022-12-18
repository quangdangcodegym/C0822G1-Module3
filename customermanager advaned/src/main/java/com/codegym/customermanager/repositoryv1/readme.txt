public class ReflectMethodinvokeExample1  {

    private static void process(String str) {
        System.out.println("processing " + str);
    }

    public static void main(String... args) throws NoSuchMethodException,
            InvocationTargetException, IllegalAccessException {
        Method m = ReflectMethodinvokeExample1.class.getDeclaredMethod("process", String.class);
        Object rv = m.invoke(null, "test");     // null ở đây là đang chạy static void, rv là kiểu của hàm trả về
        System.out.println(rv);
    }
}

//    Tạo đối tượng để chạy
Object obj = ReflectMethodinvokeExample1.class.getDeclaredConstructor().newInstance();
T obj là đối tượng tham số của hàm có thể dùng để invoke

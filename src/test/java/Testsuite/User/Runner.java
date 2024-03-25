package Testsuite.User;

import com.intuit.karate.junit5.Karate;
import static org.junit.internal.Classes.getClass;

public class Runner {
    @Karate.Test
    public Karate runUser(){
        return Karate.run("user").relativeTo((getClass()));
    }
    @Karate.Test
    public Karate runLogged(){
        return Karate.run("CreateNewUserWithTokenLogged").relativeTo(getClass());
    }
}

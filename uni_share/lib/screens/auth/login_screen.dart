

import 'package:flutter/material.dart';
import 'package:uni_share/components/text_input_feilds.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/screens/auth/signUp_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        
        alignment: Alignment.center,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            
            Text(
              'Uni-Share',
              style: TextStyle(
                fontSize: 35,
                color: buttonColor,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 15,),
            Text(
              'Login',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 28,),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal:20),
              child:TextInputField(
                controller: _emailController,
                labelText: 'Email',
                icon: Icons.email)
            ),
            const SizedBox(height: 15,),

            Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _passwordController,
                  labelText: 'Password',
                  icon: Icons.password,
                  isObscure: true,
                  ),
                ),

                const SizedBox(height: 35,),


                Container(
                  width: MediaQuery.of(context).size.width-60,
                  height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: const BorderRadius.all(Radius.circular(5),
                    ),
                  ),
                 child: InkWell(
                  onTap: (){
                    
                  },
                  child:Center(
                    child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),),
                 ),


                ),

                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don\'t have an account?",style: TextStyle(fontSize: 20,),),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));

                      },
                      child: Text(
                        
                        "Register Now!",
                        style: TextStyle(fontSize: 20,color: buttonColor,fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )




          ],
        )
      )
    );
  }
}
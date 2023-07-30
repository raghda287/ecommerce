import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/component.dart';
import '../shop_layout/shop.dart';
import 'cubit/login_cubit.dart';


class ShopLogin extends StatelessWidget {
final FormKey = GlobalKey<FormState>();
@override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var PasswordController=TextEditingController();

    return BlocProvider(
      create: (BuildContext context) =>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (BuildContext context,  state) {

        },

        builder: (BuildContext context, state) {
          var cubit=  LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body:Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: FormKey,
                    child: Column (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('LOGIN',
                            style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                        Text('login now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        TextFormField(

                          controller:emailController ,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value!.isEmpty){
                              return'please enter your email address';
                            }
                          },
                          decoration:  InputDecoration(
                            label: Text('Email Address'),
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                          ),


                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(


                          controller:PasswordController ,
                          keyboardType: TextInputType.visiblePassword,


                          validator: (value){
                            if(value!.isEmpty){
                              return'password is too short';
                            }
                          },

                          decoration:  InputDecoration(
                            label: Text('Password'),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: Icon(Icons.visibility,),



                            border: OutlineInputBorder(),
                          ),


                        ),
                        SizedBox(
                          height: 40.0,
                        ),
            ConditionalBuilder(
              condition: !cubit.isLoading,
              fallback: (context)=>CircularProgressIndicator(),
              builder: (context){
                return ElevatedButton(onPressed: (){FormKey.currentState?.validate();
                cubit.userLogin(email: emailController.text, password: PasswordController.text)!
                    .then((value) {
if(state is LoginSuccess){
  navigateTo(context, Shop_Layout());
}else{
  print(false);
}
                    });
                    }, child: Text(
                    'Login'
                ));
              },

            ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?' ),
                            defaultTextButton
                              (
                              text: 'Register',

                              function: (){
                                navigateAndFinish(context, Shop_Layout(),);
                              },
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }

      ),
    );
  }
}

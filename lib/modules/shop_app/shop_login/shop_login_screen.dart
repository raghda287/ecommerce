import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/shop_layout/shop.dart';
import 'package:shop_app/modules/shop_app/shop_login/cubit/login_cubit.dart';
import 'package:shop_app/modules/shop_app/shop_register/shop_register_screen.dart';
import 'package:shop_app/shared/components/component.dart';

class ShopLogin extends StatelessWidget {
final FormKey = GlobalKey<FormState>();
@override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var PasswordController=TextEditingController();

    return BlocProvider(
      create: (BuildContext context) =>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (BuildContext context, Object? state) {  },

        builder: (BuildContext context, state) =>Scaffold(
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
                        key: key,
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


                        key: key,
                        controller:PasswordController ,
                        keyboardType: TextInputType.visiblePassword,
                        onFieldSubmitted: (value) {
                          if (FormKey.currentState!.validate()) {
                            LoginCubit.get(context).userLogin(
                              email: emailController.text,
                              password: PasswordController.text,
                            );
                          }
                        },


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
                          condition: state is! LoginLoading,
                      builder: (BuildContext context) => defaultButton(function: (){

                      }, text: 'LOGIN',),
                      fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),
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
        ),

      ),
    );
  }
}

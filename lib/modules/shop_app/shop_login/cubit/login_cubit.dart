import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginInitial());
  static LoginCubit get(Context)=> BlocProvider.of(Context);
  LoginModel ?loginmodel;
   void userLogin({
  @required email,
    @required password,
})
   {
     emit(LoginLoading());
     DioHelper.postData(url:LOGIN,data:
{
       'email':email,
       'password':password,
     },
     ).then((value)
     {
       print(value);
       loginmodel=LoginModel.fromJson(value.data);
       emit(LoginSuccess(loginmodel!));
     }).catchError((error){
       emit(LoginError(error.toString()));
     }
     );
   }
   IconData Suffix =Icons.visibility;
   bool isPassword = true;

   void ChangePasswordVisibility(){
     isPassword!=isPassword;
     Suffix=isPassword ?Icons.visibility :Icons.visibility_off;
     emit(ChangePasswordVisibilityState());
   }















}

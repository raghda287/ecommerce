import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/login_model.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  LoginCubit() : super(LoginInitial());
  static LoginCubit get(Context)=> BlocProvider.of(Context);
  LoginModel ?loginmodel;
    userLogin({
  @required email,
    @required password,
})
   async {
     isLoading=true;
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
       isLoading=false;
       emit(LoginSuccess(loginmodel!));
     }).catchError((error){
       isLoading=false;
       emit(LoginError(error.toString()));
     }
     );
   }
   IconData Suffix =Icons.visibility;
   bool isPassword = true;
bool isLoading=false;
   void ChangePasswordVisibility(){
     isPassword!=isPassword;
     Suffix=isPassword ?Icons.visibility :Icons.visibility_off;
     emit(ChangePasswordVisibilityState());
   }















}

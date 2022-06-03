
Parse.Cloud.beforeSave(Parse.User,async(req)=>{
  let user = req.object;
  console.log(`beforeSave User with ${user.email}. Create profile.`);
  console.log(`beforeSave User getEmail ${user.get('email')}. Create profile.`);

  if(user.get('profile')===undefined){
    const userProfile = new Parse.Object("UserProfile");
    userProfile.set('email',user.get('email'));
    let userProfileResult = await userProfile.save(null,{ useMasterKey: true });
    user.set('profile',userProfileResult);
  }
});

// Parse.Cloud.afterSave(Parse.User,async(req)=>{
//   let user = req.object;
//   console.log(`afterSave user ${user.id}. Set ACL profile`);
//   const profile = new Parse.Object("Profile");
//   profile.id= user.get('profile').id;
//   const profileACL = new Parse.ACL(user);
//   profileACL.setPublicReadAccess(false);
//   profileACL.setPublicWriteAccess(false);
//   // profileACL.setReadAccess(user,true);
//   // profileACL.setWriteAccess(user,true);
//   profile.setACL(profileACL)
//   let profileResult = await profile.save(null,{ useMasterKey: true });

//   let userCurrent = req.object;
//   userCurrent.set('profile',profileResult);
// });

Parse.Cloud.afterDelete(Parse.User,async(req)=>{
  let user = req.object;

  console.log(`afterDelete user ${user.id}`);
  let userProfileId = user.get('profile').id;
  console.log(`delete UserProfile ${userProfileId}`);
  const userProfile = new Parse.Object("UserProfile");
  userProfile.id = userProfileId;
  await userProfile.destroy({ useMasterKey: true });
});

import Map "mo:core/Map";
import Text "mo:core/Text";
import Time "mo:core/Time";
import Runtime "mo:core/Runtime";
import Array "mo:core/Array";
import Int "mo:core/Int";
import Iter "mo:core/Iter";
import Storage "mo:caffeineai-object-storage/Storage";
import AccessControl "mo:caffeineai-authorization/access-control";

// Generated initial migration: seeds all stable actor state on a fresh
// install. Actor type definitions are inlined so this frozen chain entry
// does not drift if the actor's types change in a later version.
module {
  type WorkEntry = {
    company : Text;
    title : Text;
    startYear : Text;
    endYear : Text;
    description : Text;
  };

  type EducationEntry = {
    school : Text;
    degree : Text;
    field : Text;
    year : Text;
  };

  type ProfileVisibility = { #Public; #ConnectionsOnly };

  type Profile = {
    name : Text;
    headline : Text;
    location : Text;
    industry : Text;
    bio : Text;
    skills : [Text];
    workHistory : [WorkEntry];
    education : [EducationEntry];
    avatar : ?Storage.ExternalBlob;
    resume : ?Storage.ExternalBlob;
    createdAt : Int;
    profileVisibility : ProfileVisibility;
  };

  type UserSummary = {
    principal : Principal;
    name : Text;
    headline : Text;
    avatar : ?Storage.ExternalBlob;
  };

  type Endorsement = {
    skill : Text;
    endorserPrincipal : Principal;
    createdAt : Int;
  };

  type ConnStatus = { #Pending; #Accepted; #Declined };

  type ConnRequest = {
    id : Nat;
    from : Principal;
    to : Principal;
    status : ConnStatus;
    createdAt : Int;
  };

  type Message = {
    id : Nat;
    from : Principal;
    to : Principal;
    body : Text;
    attachment : ?Storage.ExternalBlob;
    attachmentName : ?Text;
    createdAt : Int;
    read : Bool;
  };

  type ConversationPreview = {
    partner : Principal;
    lastMessage : Text;
    lastMessageAt : Int;
    unreadCount : Nat;
  };

  type JobPosting = {
    id : Nat;
    posterPrincipal : Principal;
    title : Text;
    company : Text;
    description : Text;
    requirements : Text;
    salaryRange : Text;
    location : Text;
    industry : Text;
    experienceLevel : Text;
    createdAt : Int;
    active : Bool;
  };

  type ApplicationStatus = { #Applied; #Accepted; #Rejected };

  type JobApplication = {
    id : Nat;
    jobId : Nat;
    applicantPrincipal : Principal;
    coverLetter : Text;
    resume : ?Storage.ExternalBlob;
    createdAt : Int;
    status : ApplicationStatus;
  };

  type PostType = { #Article; #Question; #Insight };

  type Group = {
    id : Nat;
    name : Text;
    description : Text;
    industry : Text;
    creatorPrincipal : Principal;
    createdAt : Int;
    memberCount : Nat;
  };

  type GroupPost = {
    id : Nat;
    groupId : Nat;
    authorPrincipal : Principal;
    body : Text;
    postType : PostType;
    createdAt : Int;
    likeCount : Nat;
  };

  type PostComment = {
    id : Nat;
    postId : Nat;
    authorPrincipal : Principal;
    body : Text;
    createdAt : Int;
  };

  type NotifKind = {
    #ConnectionRequest;
    #ConnectionAccepted;
    #NewMessage;
    #PostLiked;
    #PostCommented;
    #JobApplicationReceived;
    #GroupPostCreated;
    #SkillEndorsed;
  };

  type Notification = {
    id : Nat;
    recipientPrincipal : Principal;
    kind : NotifKind;
    referenceId : Nat;
    message : Text;
    read : Bool;
    createdAt : Int;
  };

  public func migration(_ : {}) : {
    accessControlState : AccessControl.AccessControlState;
    userProfiles : Map.Map<Principal, Profile>;
    userEndorsements : Map.Map<Principal, [Endorsement]>;
    connRequests : Map.Map<Nat, ConnRequest>;
    var nextConnRequestId : Nat;
    userIncomingRequests : Map.Map<Principal, Map.Map<Nat, Bool>>;
    userOutgoingRequests : Map.Map<Principal, Map.Map<Nat, Bool>>;
    userConnections : Map.Map<Principal, Map.Map<Principal, Bool>>;
    messages : Map.Map<Nat, Message>;
    var nextMsgId : Nat;
    userMsgIndex : Map.Map<Principal, Map.Map<Principal, Map.Map<Nat, Bool>>>;
    jobPostings : Map.Map<Nat, JobPosting>;
    var nextJobId : Nat;
    jobApplicantIndex : Map.Map<Nat, Map.Map<Nat, Bool>>;
    userApplicationsIndex : Map.Map<Principal, Map.Map<Nat, Bool>>;
    jobApplications : Map.Map<Nat, JobApplication>;
    var nextApplicationId : Nat;
    groups : Map.Map<Nat, Group>;
    var nextGroupId : Nat;
    groupMemberships : Map.Map<Principal, Map.Map<Nat, Bool>>;
    groupMembers : Map.Map<Nat, Map.Map<Principal, Bool>>;
    groupPosts : Map.Map<Nat, GroupPost>;
    var nextPostId : Nat;
    groupPostIndex : Map.Map<Nat, Map.Map<Nat, Bool>>;
    postComments : Map.Map<Nat, PostComment>;
    var nextCommentId : Nat;
    postCommentIndex : Map.Map<Nat, Map.Map<Nat, Bool>>;
    postLikes : Map.Map<Nat, Map.Map<Principal, Bool>>;
    userNotifications : Map.Map<Principal, Map.Map<Nat, Notification>>;
    var nextNotifId : Nat;
    blockedUsers : Map.Map<Principal, Map.Map<Principal, Bool>>;
  } {
    {
      accessControlState = AccessControl.initState();
      userProfiles = Map.empty();
      userEndorsements = Map.empty();
      connRequests = Map.empty();
      var nextConnRequestId = 0;
      userIncomingRequests = Map.empty();
      userOutgoingRequests = Map.empty();
      userConnections = Map.empty();
      messages = Map.empty();
      var nextMsgId = 0;
      userMsgIndex = Map.empty();
      jobPostings = Map.empty();
      var nextJobId = 0;
      jobApplicantIndex = Map.empty();
      userApplicationsIndex = Map.empty();
      jobApplications = Map.empty();
      var nextApplicationId = 0;
      groups = Map.empty();
      var nextGroupId = 0;
      groupMemberships = Map.empty();
      groupMembers = Map.empty();
      groupPosts = Map.empty();
      var nextPostId = 0;
      groupPostIndex = Map.empty();
      postComments = Map.empty();
      var nextCommentId = 0;
      postCommentIndex = Map.empty();
      postLikes = Map.empty();
      userNotifications = Map.empty();
      var nextNotifId = 0;
      blockedUsers = Map.empty();
    };
  };
};

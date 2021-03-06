open Generic_core
open Ty.T

let (-<) = Generic_util_fun.(-<)

type empty (* empty type : no value *)
type ('a,'b) sum = Left of 'a | Right of 'b

let left x = Left x
let right x = Right x

let empty_elim (_ : empty) = assert false
(* it shouldn't be possible to execute that function since we cannot give it any actual argument *)

let either l r = function
  | Left x -> l x
  | Right x -> r x

let sum l r = either (left -< l) (right -< r)


(* TODO Boiler plate generated by reify *)
type _ ty +=
    Empty : empty ty
  | Sum : 'a ty * 'b ty -> ('a, 'b) sum ty

(*type _ Generic_core.Ty.ty +=
  | Empty: empty Generic_core.Ty.ty
let () =
  Generic_core.Desc_fun.ext_add_con (Generic_core.Ty.Ty Empty)
    {
      Generic_core.Desc.Ext.con = fun (type a) ->
        fun (ty : a Generic_core.Ty.ty)  ->
          (match ty with
           | Generic_core.Ty.Ty (Empty ) ->
               Generic_core.Desc.Con.make "Empty" Generic_core.Product.T.Nil
                 (fun ()  -> Empty)
                 (function | Empty  -> Some () | _ -> None)
           | _ -> assert false : a Generic_core.Desc.Con.t)
    }

let () =
  Generic_core.Desc_fun.ext Empty
    {
      Generic_core.Desc_fun.f = fun (type a) ->
        fun (ty : a Generic_core.Ty.ty)  ->
          (match ty with
           | Empty  -> Generic_core.Desc.Abstract
           | _ -> assert false : a Generic_core.Desc.t)
    }

type _ Generic_core.Ty.ty +=
  | Sum: 'a1 Generic_core.Ty.ty* 'a2 Generic_core.Ty.ty -> ('a1,'a2) sum
  Generic_core.Ty.ty
let () =
  Generic_core.Desc_fun.ext_add_con
    (Generic_core.Ty.Ty (Sum (Generic_core.Ty.Any, Generic_core.Ty.Any)))
    {
      Generic_core.Desc.Ext.con = fun (type a) ->
        fun (ty : a Generic_core.Ty.ty)  ->
          (match ty with
           | Generic_core.Ty.Ty (Sum (x1,x2)) ->
               Generic_core.Desc.Con.make "Sum"
                 (Generic_core.Product.T.Cons
                    ((Generic_core.Ty.Ty x1),
                      (Generic_core.Product.T.Cons
                         ((Generic_core.Ty.Ty x2),
                           Generic_core.Product.T.Nil))))
                 (fun (x1,(x2,()))  -> Sum (x1, x2))
                 (function | Sum (x1,x2) -> Some (x1, (x2, ())) | _ -> None)
           | _ -> assert false : a Generic_core.Desc.Con.t)
    }

let () =
  Generic_core.Desc_fun.ext (Sum (Generic_core.Ty.Any, Generic_core.Ty.Any))
    {
      Generic_core.Desc_fun.f = fun (type a) ->
        fun (ty : a Generic_core.Ty.ty)  ->
          (match ty with
           | Sum (x1,x2) ->
               Generic_core.Desc.Variant
                 {
                   Generic_core.Desc.Variant.name = "sum";
                   Generic_core.Desc.Variant.module_path =
                     ["Generic_util_sum"];
                   Generic_core.Desc.Variant.cons =
                     (Generic_core.Desc.Variant.cons
                        [Generic_core.Desc.Con.make "Left"
                           (Generic_core.Product.T.Cons
                              (x1, Generic_core.Product.T.Nil))
                           (fun (x1,())  -> Left x1)
                           (function | Left x1 -> Some (x1, ()) | _ -> None);
                        Generic_core.Desc.Con.make "Right"
                          (Generic_core.Product.T.Cons
                             (x2, Generic_core.Product.T.Nil))
                          (fun (x1,())  -> Right x1)
                          (function | Right x1 -> Some (x1, ()) | _ -> None)])
                 }
           | _ -> assert false : a Generic_core.Desc.t)
    }
*)

(** List of constructors view.
    Inspired by haskell Replib library.
    Records and products are viewed as a list of one constructor.
    Abstract types are dealt with by viewing their public representation.
    Synonyms are followed,
    Base types and custom types are ignored: Int, Int32, Int64, Char, Float, String, Bytes, Array.
*)

open Generic_core
open Generic_util
open Desc
open Ty.T
let ( -< ) = Fun.(-<)

type 'a view = 'a Con.t list option

let set_map from set r x = set (from r) x


let field_map m = let open Field.T in
  fun {name; ty; set} ->
    {name; ty; set = Option.map (set_map m) set}

let rec fields_map : type p . ('b -> 'a) -> (p, 'a) Fields.t -> (p, 'b) Fields.t
  = fun m -> let open Fields.T in function
  | Nil -> Nil
  | Cons (f, fs) -> Cons (field_map m f, fields_map m fs)

(** @raise Exn.Failed if the representation doesn't correspond to a valid abstract value *)
let repr r (Con.Con {name; args; embed; proj}) =
    Con.Con { name = name
            ; args = fields_map r.Repr.to_repr args
            ; embed = Option.get_some -< r.Repr.from_repr -< embed
            ; proj = proj -< r.to_repr
            }

let rec view : type a . a ty -> a view
  = fun t ->
    match Desc_fun.view t with
    | Product (p, iso) ->
      Some [Con { name  = ""
                ; args  = Fields.anon p
                ; embed = iso.fwd
                ; proj  = (fun x -> Some (iso.bck x))
                }
           ]
    | Record r ->
      Some [Con { name  = ""
                ; args  = r.fields
                ; embed = r.iso.fwd
                ; proj  = (fun x -> Some (r.iso.bck x))
                }
           ]
    | Variant v -> Some (Variant.con_list v.cons)
    | Extensible e -> Some (Ext.con_list e)
    | Synonym (t', eq) -> (match eq with
          Equal.Refl -> view t')
    | Abstract ->
      (match Repr.repr t with
       | Repr.Repr r -> Option.map (List.map (repr r)) (view r.repr_ty))
    | _ -> None

import { LightningElement } from 'lwc';

export default class CarouselParent extends LightningElement {
    carousels = [
        {
            src: "https://thumbs.dreamstime.com/b/happy-little-havanese-puppy-sitting-grass-orange-dog-45886384.jpg",
            header: "Puppy",
            description: "Puppy card description.",
            alternativeText: "Puppy card accessible description.",
            href: "javascript:void(0);"
        },
        {
            src: "https://www.shutterstock.com/image-photo/british-shorthair-kitten-silver-color-260nw-1510641710.jpg",
            header: "Kitten",
            description: "Kitten card description.",
            alternativeText: "Kitten card accessible description.",
            href: "javascript:void(0);"
        },
        {
            src: "https://static.vecteezy.com/system/resources/previews/026/840/979/non_2x/close-up-shot-of-a-wild-tiger-roaring-free-photo.jpg",
            header: "Tiger",
            description: "Tiger card description.",
            alternativeText: "Tiger card accessible description.",
            href: "javascript:void(0);"
        },
        {
            src: "https://thumbs.dreamstime.com/b/baby-panda-tree-chengdu-research-base-giant-breeding-30774508.jpg",
            header: "Panda",
            description: "Panda card description.",
            alternativeText: "Panda card accessible description.",
            href: "javascript:void(0);"
        }
    ];
}